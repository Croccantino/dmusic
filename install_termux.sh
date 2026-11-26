#!/data/data/com.termux/files/usr/bin/bash
# install_termux.sh — installa dmusic su Termux (Android)
set -e

echo "==> Aggiornamento pacchetti Termux..."
pkg update -y && pkg upgrade -y

echo "==> Installazione Python e dipendenze di sistema..."
pkg install -y python ffmpeg

echo "==> Installazione pip dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "==> Installazione deno..."
pkg install -y deno 2>/dev/null || curl -fsSL https://deno.land/install.sh | sh

echo "==> Installazione del comando 'dmusic'..."
mkdir -p "$HOME/.local/bin"
cp download_audio_youtube.py "$HOME/.local/bin/download_audio_youtube.py"
cat > "$HOME/.local/bin/dmusic" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
exec python "$HOME/.local/bin/download_audio_youtube.py" "$@"
EOF
chmod +x "$HOME/.local/bin/dmusic"

if ! grep -q '.local/bin' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "==> Installazione completata!"
echo "Riapri Termux oppure: source ~/.bashrc"
echo "Uso: dmusic <URL> --format m4a"
