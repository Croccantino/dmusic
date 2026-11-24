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

## Installazione (Linux / macOS)

### Metodo rapido

```bash
chmod +x install.sh
./install.sh
```

Lo script installa le dipendenze, deno (se manca) e il comando `dmusic` in `~/.local/bin`.

Dopo l'installazione riapri il terminale (o `source ~/.bashrc`), poi:

```bash
dmusic --help
```

### Metodo manuale

```bash
# 1. Clona il repository
git clone https://github.com/Croccantino/dmusic.git
cd dmusic

# 2. Installa le dipendenze Python
python3 -m pip install -r requirements.txt

# 3. Installa deno (richiesto da yt-dlp per YouTube)
curl -fsSL https://deno.land/install.sh | sh
export PATH="$HOME/.deno/bin:$PATH"

# 4. Verifica
python3 download_audio_youtube.py --help
```

### Comandi di debug

```bash
python3 --version
yt-dlp --version
deno --version 2>/dev/null | head -n1
```

### Usare il comando dmusic

Dopo l'installazione:

```bash
dmusic https://youtu.be/VIDEO_ID --format m4a
dmusic https://youtube.com/playlist?list=PLAYLIST_ID -p
dmusic
```

## Installazione (Windows)

### Requisiti

- Python 3.8+ (da https://www.python.org/downloads/, spunta "Add Python to PATH")
- deno (`winget install DenoLand.Deno`)

### Metodo rapido (cmd)

```cmd
install.bat
```

Installa le dipendenze e il comando `dmusic` in `%USERPROFILE%\bin`.

Dopo l'installazione aggiungi `%USERPROFILE%\bin` al PATH se non presente:

```cmd
setx PATH "%PATH%;%USERPROFILE%\bin"
```

Poi apri un nuovo terminale e verifica:

```cmd
dmusic --help
```

### Metodo manuale (PowerShell)

```powershell
git clone https://github.com/Croccantino/dmusic.git
cd dmusic
python -m pip install -r requirements.txt
winget install DenoLand.Deno
python download_audio_youtube.py --help
```

### Usare il comando dmusic (Windows)

```cmd
dmusic https://youtu.be/VIDEO_ID --format m4a
dmusic https://youtube.com/playlist?list=PLAYLIST_ID -p
dmusic
```

### Comandi di debug (Windows)

```cmd
python --version
yt-dlp --version
deno --version
where dmusic
```
