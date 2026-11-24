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

## Installazione

### Metodo rapido (script automatico)

```bash
chmod +x install.sh
./install.sh
```

Lo script stampa (echo) ogni passaggio:

```bash
echo "==> Verifica Python..."
echo "==> Aggiornamento pip..."
echo "==> Installazione dipendenze Python (yt-dlp)..."
echo "==> Verifica yt-dlp..."
echo "==> Verifica deno (runtime JS per YouTube)..."
echo "==> Installazione completata!"
```

### Metodo manuale

```bash
# 1. Clona il repository
git clone https://github.com/Croccantino/dmusic.git
cd dmusic

# 2. (Opzionale) crea un virtualenv
python3 -m venv venv
source venv/bin/activate

# 3. Installa le dipendenze Python
pip install -r requirements.txt

# 4. Installa deno (richiesto da yt-dlp per YouTube)
curl -fsSL https://deno.land/install.sh | sh
export PATH="$HOME/.deno/bin:$PATH"

# 5. Verifica
python3 download_audio_youtube.py --help
```

### Comandi echo utili (debug)

```bash
echo "Python: $(python3 --version)"
echo "yt-dlp: $(yt-dlp --version)"
echo "deno: $(deno --version 2>/dev/null | head -n1)"
echo "PATH deno: $HOME/.deno/bin"
```
