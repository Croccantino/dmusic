@echo off
REM uninstall.bat — rimuove dmusic su Windows
setlocal

echo ==> Rimozione del comando dmusic...
del /Q "%USERPROFILE%\bin\dmusic.bat" 2>nul
del /Q "%USERPROFILE%\bin\download_audio_youtube.py" 2>nul

echo ==> Rimozione delle dipendenze Python (yt-dlp)...
python -m pip uninstall -y yt-dlp

echo ==> Rimozione completata.
echo Nota: deno e Python NON sono stati rimossi.
echo Per rimuovere deno: rmdir /S /Q "%USERPROFILE%\.deno"
