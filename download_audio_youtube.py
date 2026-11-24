#!/usr/bin/env python3
import subprocess
import sys
import os
import argparse
import re
import shutil

DOWNLOAD_DIR = os.path.expanduser("~/Music/downloaded_track")
ALL_FORMATS = ["mp3", "m4a", "opus", "aac", "wav", "flac", "ogg"]


def is_playlist_url(url: str) -> bool:
    return bool(re.search(r"(/playlist\?|list=)", url))


def clean_url(url: str) -> str:
    return url.split("&si=")[0].split("?si=")[0] if "si=" in url else url


def get_playlist_title(url: str) -> str:
    try:
        result = subprocess.run(
            ["yt-dlp", "--no-update", "--print", "playlist_title", url],
            capture_output=True, text=True, timeout=30,
        )
        if result.returncode == 0 and result.stdout.strip():
            title = result.stdout.strip()
            title = re.sub(r'[\\/*?:"<>|]', "", title).strip()
            if title:
                return title
    except Exception:
        pass
    match = re.search(r"[&?]list=([\w-]+)", url)
    return match.group(1) if match else "playlist"


def build_cmd(audio_format: str, outtmpl: str, url: str, no_playlist: bool = False) -> list[str]:
    cmd = [
        "yt-dlp", "-x",
        "--audio-format", audio_format,
        "--audio-quality", "0",
        "--add-metadata",
        "--no-update",
        "--js-runtimes", f"deno:{os.path.expanduser('~/.deno/bin/deno')}",
        "--extractor-args", "youtube:player_client=web_embedded",
        "-o", outtmpl,
        url,
    ]
    # wav/aac non supportano l'embedding della copertina
    if audio_format not in ("wav", "aac"):
        cmd.insert(5, "--embed-thumbnail")
    if no_playlist:
        cmd.insert(2, "--no-playlist")
    return cmd


def run_cmd(cmd: list[str]) -> None:
    """Esegue il download, ritentando in caso di errore HTTP 403."""
    error = None
    for attempt in range(1, 4):
        try:
            subprocess.run(cmd, check=True)
            return
        except subprocess.CalledProcessError as e:
            error = e
            if "403" in str(e) and attempt < 3:
                print(f"HTTP 403, nuovo tentativo ({attempt + 1}/3)...", file=sys.stderr)
                continue
            raise
    raise error  # type: ignore[misc]


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Scarica tracce audio da YouTube in vari formati.",
        epilog="Esempio: dmusic https://youtu.be/... --format m4a",
    )
    parser.add_argument("url", nargs="?", help="URL del video o playlist YouTube")
    parser.add_argument("-f", "--format", dest="audio_format", choices=ALL_FORMATS,
                        help=f"Formato audio. Supportati: {', '.join(ALL_FORMATS)}")
    parser.add_argument("-o", "--output", dest="output_dir", default=DOWNLOAD_DIR,
                        help="Directory di output (default: ~/Music/downloaded_track)")
    parser.add_argument("-p", "--playlist", action="store_true",
                        help="Forza download playlist")
    args = parser.parse_args()

    url = (args.url or "").strip()
    if not url:
        url = input("Incolla il link YouTube: ").strip()
        if not url:
            print("Nessun URL fornito.", file=sys.stderr)
            sys.exit(1)
        fmt = args.audio_format if args.audio_format else pick_format()
    else:
        url = clean_url(url)
        fmt = args.audio_format if args.audio_format else "mp3"
        if not args.audio_format:
            print("Formato: mp3 (usa -f per cambiarlo)")

    playlist_mode = args.playlist or is_playlist_url(url)

    if playlist_mode:
        playlist_title = get_playlist_title(url)
        playlist_dir = os.path.join(args.output_dir, playlist_title)
        outtmpl = os.path.join(playlist_dir, "%(playlist_index)02d - %(title)s.%(ext)s")
        cmd = build_cmd(fmt, outtmpl, url)

        print(f"Download playlist in: {playlist_dir}")

        try:
            run_cmd(cmd)
        except subprocess.CalledProcessError as e:
            print(f"Errore: {e}", file=sys.stderr)
            sys.exit(1)
        except FileNotFoundError:
            print("yt-dlp non trovato. Installa con: pip install yt-dlp", file=sys.stderr)
            sys.exit(1)

        zip_path = shutil.make_archive(playlist_dir, "zip", playlist_dir)
        print(f"Cartella:   {playlist_dir}/")
        print(f"Archivio:   {zip_path}")
    else:
        outtmpl = os.path.join(args.output_dir, "%(title)s.%(ext)s")
        cmd = build_cmd(fmt, outtmpl, url, no_playlist=True)

        try:
            run_cmd(cmd)
            print(f"Download completato in: {args.output_dir} in formato {fmt}")
        except subprocess.CalledProcessError as e:
            print(f"Errore: {e}", file=sys.stderr)
            sys.exit(1)
        except FileNotFoundError:
            print("yt-dlp non trovato. Installa con: pip install yt-dlp", file=sys.stderr)
            sys.exit(1)


def pick_format() -> str:
    print("Scegli il formato audio (numero):")
    for i, fmt in enumerate(ALL_FORMATS, 1):
        print(f"  [{i}] {fmt}")
    choice = input("Formato (default mp3): ").strip()
    if choice.isdigit() and 1 <= int(choice) <= len(ALL_FORMATS):
        return ALL_FORMATS[int(choice) - 1]
    return "mp3"


if __name__ == "__main__":
    main()
