@echo off
REM install.bat — installa dmusic su Windows
echo ==> Verifica Python...
python --version

echo ==> Aggiornamento pip...
python -m pip install --upgrade pip

echo ==> Installazione dipendenze Python (yt-dlp)...
python -m pip install -r requirements.txt

echo ==> Verifica yt-dlp...
yt-dlp --version

echo ==> Verifica deno (runtime JS per YouTube)...
where deno >nul 2>&1
if %errorlevel% neq 0 (
    echo deno non trovato. Scaricalo da https://deno.land/ e aggiungilo al PATH.
) else (
    deno --version
)

echo ==> Installazione del comando dmusic...
if not exist "%USERPROFILE%\bin" mkdir "%USERPROFILE%\bin"
copy /Y dmusic.bat "%USERPROFILE%\bin\dmusic.bat" >nul
echo Aggiunto dmusic a %USERPROFILE%\bin
echo Assicurati che %USERPROFILE%\bin sia nel tuo PATH.

echo ==> Installazione completata!
echo Uso: dmusic ^<URL^> --format m4a
echo Oppure: dmusic   (modalita' interattiva)
echo Esempio: dmusic https://youtu.be/dQw4w9WgXcQ --format mp3
