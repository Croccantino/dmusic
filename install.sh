#!/usr/bin/env bash
# install.sh — installa dmusic e le sue dipendenze
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Verifica Python..."
python3 --version

echo "==> Aggiornamento pip..."
python3 -m pip install --upgrade pip 2>/dev/null || true

echo "==> Installazione dipendenze Python (yt-dlp)..."
if python3 -c "import yt_dlp" 2>/dev/null; then
    echo "yt-dlp già installato"
else
    python3 -m pip install -r "$REPO_DIR/requirements.txt" --break-system-packages 2>/dev/null \
        || python3 -m pip install -r "$REPO_DIR/requirements.txt"
fi

echo "==> Verifica yt-dlp..."
yt-dlp --version

echo "==> Verifica deno (runtime JS per YouTube)..."
if command -v deno >/dev/null 2>&1; then
    echo "deno già installato: $(deno --version | head -n1)"
else
    echo "deno non trovato, installo..."
    curl -fsSL https://deno.land/install.sh | sh
    export PATH="$HOME/.deno/bin:$PATH"
fi

echo "==> Installazione del comando 'dmusic'..."
mkdir -p "$HOME/.local/bin"
cp "$REPO_DIR/download_audio_youtube.py" "$HOME/.local/bin/download_audio_youtube.py"
cat > "$HOME/.local/bin/dmusic" <<'EOF'
#!/usr/bin/env bash
exec python3 "$HOME/.local/bin/download_audio_youtube.py" "$@"
EOF
chmod +x "$HOME/.local/bin/dmusic"

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Aggiunto ~/.local/bin al PATH in ~/.bashrc"
fi

echo "==> Installazione completata!"
echo "Riapri il terminale oppure esegui: source ~/.bashrc"
echo "Uso: dmusic <URL> --format m4a"
echo "Oppure: dmusic   (modalità interattiva)"
echo "Esempio: dmusic https://youtu.be/dQw4w9WgXcQ --format mp3"
