@echo off
REM install.bat — installa dmusic su Windows
setlocal

echo ==> Verifica Python...
python --version
if errorlevel 1 (
    echo Python non trovato. Installalo da https://www.python.org/downloads/ e spunta "Add Python to PATH".
    exit /b 1
)

echo ==> Aggiornamento pip...
python -m pip install --upgrade pip

echo ==> Installazione dipendenze Python (yt-dlp)...
python -m pip install -r requirements.txt

echo ==> Verifica yt-dlp...
yt-dlp --version

echo ==> Verifica deno (runtime JS per YouTube)...
where deno >nul 2>&1
if %errorlevel% neq 0 (
    echo deno non trovato. Installalo con: winget install DenoLand.Deno
) else (
    deno --version
)

echo ==> Installazione del comando dmusic...
if not exist "%USERPROFILE%\bin" mkdir "%USERPROFILE%\bin"
copy /Y "%~dp0download_audio_youtube.py" "%USERPROFILE%\bin\download_audio_youtube.py" >nul
(
    echo @echo off
    echo python "%USERPROFILE%\bin\download_audio_youtube.py" %%*
) > "%USERPROFILE%\bin\dmusic.bat"

echo Aggiunto dmusic a %USERPROFILE%\bin
echo Assicurati che %USERPROFILE%\bin sia nel tuo PATH.
echo Per aggiungerlo: setx PATH "%%PATH%%;%%USERPROFILE%%\bin"

echo ==> Installazione completata!
echo Uso: dmusic ^<URL^> --format m4a
echo Oppure: dmusic   (modalita' interattiva)
echo Esempio: dmusic https://youtu.be/dQw4w9WgXcQ --format mp3
