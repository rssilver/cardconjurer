@echo off
set PORT=4242
set HOST=127.0.0.1

echo Starting Card Conjurer on http://%HOST%:%PORT%/
echo (Open the root URL, then click 'Card Creator' in the menu)
echo Press Ctrl+C to stop.

:: Try Node.js serve first
where node >nul 2>nul
if %errorlevel% equ 0 (
    npx -y serve -l %PORT% .
    goto end
)

:: Fallback to Python
where python >nul 2>nul
if %errorlevel% equ 0 (
    python -m http.server %PORT% --bind %HOST%
    goto end
)

echo Error: Need Python or Node.js installed.
exit /b 1

:end
