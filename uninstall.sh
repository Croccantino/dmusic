#!/usr/bin/env bash
# uninstall.sh — rimuove dmusic e le sue scorciatoie
set -e

echo "==> Rimozione del comando 'dmusic'..."
rm -f "$HOME/.local/bin/dmusic"
rm -f "$HOME/.local/bin/download_audio_youtube.py"

echo "==> Rimozione delle dipendenze Python (yt-dlp)..."
python3 -m pip uninstall -y yt-dlp 2>/dev/null || true

echo "==> Rimozione della riga PATH da ~/.bashrc (se presente)..."
sed -i '\|export PATH="$HOME/.local/bin:$PATH"|d' "$HOME/.bashrc" 2>/dev/null || true

echo "==> Rimozione completata."
echo "Nota: deno e Python NON sono stati rimossi."
echo "Per rimuovere deno: rm -rf ~/.deno"
