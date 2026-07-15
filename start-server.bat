@echo off
cd /d "%~dp0"
start "Kare Kare Server" /b "C:\xampp\php\php.exe" -S 127.0.0.1:4173 -t "%~dp0" > server.out.log 2> server.err.log
echo Kare Kare is running at http://127.0.0.1:4173/index.html
