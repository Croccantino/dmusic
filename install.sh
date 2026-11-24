#!/usr/bin/env bash
# install.sh — installa dmusic e le sue dipendenze
set -e

echo "==> Verifica Python..."
python3 --version

echo "==> Aggiornamento pip..."
python3 -m pip install --upgrade pip

echo "==> Installazione dipendenze Python (yt-dlp)..."
python3 -m pip install -r requirements.txt

echo "==> Verifica yt-dlp..."
yt-dlp --version

echo "==> Verifica deno (runtime JS per YouTube)..."
if ! command -v deno >/dev/null 2>&1; then
    echo "deno non trovato, installo..."
    curl -fsSL https://deno.land/install.sh | sh
    export PATH="$HOME/.deno/bin:$PATH"
else
    echo "deno già installato: $(deno --version | head -n1)"
fi

echo "==> Installazione completata!"
echo "Uso: python3 download_audio_youtube.py <URL> --format m4a"
echo "Oppure: python3 download_audio_youtube.py   (modalità interattiva)"
