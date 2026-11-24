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

### Eseguire il comando con dmusic

Dopo l'installazione puoi usare il comando `dmusic` direttamente:

```bash
echo "Scarico un singolo video..."
dmusic https://youtu.be/VIDEO_ID --format m4a

echo "Scarico una playlist..."
dmusic https://youtube.com/playlist?list=PLAYLIST_ID -p

echo "Modalità interattiva..."
dmusic
```

## Scorciatoia con echo (alias)

Invece di eseguire il programma direttamente, puoi creare la scorciatoia usando il comando `echo` (aggiunge l'alias al file di configurazione della shell).

### Linux / macOS

```bash
echo "alias dmusic='python3 $HOME/dmusic/download_audio_youtube.py'" >> ~/.bashrc
echo "export PATH=\"$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
echo "Scorciatoia creata: dmusic"
```

Verifica:

```bash
echo "Test scorciatoia:"; type dmusic
```

### Windows (cmd)

Crea il file `dmusic.bat` nella cartella utente con echo:

```cmd
echo @python "%USERPROFILE%\dmusic\download_audio_youtube.py" %%* > "%USERPROFILE%\dmusic.bat"
echo Scorciatoia creata: %USERPROFILE%\dmusic.bat
```

Aggiungi la cartella al PATH (una sola volta):

```cmd
echo setx PATH "%%PATH%%;%%USERPROFILE%%" 
```

Verifica:

```cmd
echo Test scorciatoia: & where dmusic
```

### Windows (PowerShell)

```powershell
echo "function dmusic { python `"$HOME\dmusic\download_audio_youtube.py`" @args }" >> $PROFILE
echo "Scorciatoia creata nel profilo PowerShell"
. $PROFILE
echo "Test:"; Get-Command dmusic
```

## Windows

### Requisiti

- Python 3.8+ (da https://www.python.org/downloads/, spunta "Add Python to PATH")
- yt-dlp
- deno (da https://deno.land/, oppure `winget install DenoLand.Deno`)

### Installazione automatica (cmd / PowerShell)

```cmd
install.bat
```

Lo script stampa (echo) ogni passaggio:

```cmd
echo ==> Verifica Python...
echo ==> Aggiornamento pip...
echo ==> Installazione dipendenze Python (yt-dlp)...
echo ==> Verifica yt-dlp...
echo ==> Verifica deno (runtime JS per YouTube)...
echo ==> Installazione del comando dmusic...
echo ==> Installazione completata!
```

### Installazione manuale (PowerShell)

```powershell
# 1. Clona il repository
git clone https://github.com/Croccantino/dmusic.git
cd dmusic

# 2. Installa le dipendenze Python
python -m pip install -r requirements.txt

# 3. Installa deno
winget install DenoLand.Deno

# 4. Verifica
python download_audio_youtube.py --help
```

### Eseguire il comando con dmusic (Windows)

```cmd
echo Scarico un singolo video...
dmusic https://youtu.be/VIDEO_ID --format m4a

echo Scarico una playlist...
dmusic https://youtube.com/playlist?list=PLAYLIST_ID -p

echo Modalita' interattiva...
dmusic
```

Comandi echo di debug (Windows):

```cmd
echo Python: & python --version
echo yt-dlp: & yt-dlp --version
echo deno: & deno --version
where dmusic
```

Messaggi echo stampati dal programma durante l'esecuzione:

```bash
echo "Formato: mp3 (usa -f per cambiarlo)"
echo "Download playlist in: <cartella>"
echo "Download completato in: <cartella> in formato <fmt>"
echo "HTTP 403, nuovo tentativo (x/3)..."
echo "Errore: ..."
```
