# dmusic

Download your favorite music from YouTube as audio in various formats (mp3, m4a, opus, aac, wav, flac, ogg).

Powered by [yt-dlp](https://github.com/yt-dlp/yt-dlp).

## Usage

```bash
python3 download_audio_youtube.py https://youtu.be/VIDEO_ID --format m4a
```

Or run interactively:

```bash
python3 download_audio_youtube.py
```

### Options

- `url` — YouTube video or playlist URL
- `-f, --format` — audio format (mp3, m4a, opus, aac, wav, flac, ogg). Default: mp3
- `-o, --output` — output directory (default: `~/Music/downloaded_track`)
- `-p, --playlist` — force playlist download

## Requirements

- Python 3.8+
- yt-dlp
- deno (for YouTube JS runtime)

Install Python deps:

```bash
pip install -r requirements.txt
```
