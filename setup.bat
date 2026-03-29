@echo off
chcp 65001 >nul 2>&1
title n8n YouTube Shorts Otomasyon - Kurulum

echo ╔══════════════════════════════════════════════╗
echo ║  n8n + Telegram + YouTube Shorts Kurulum     ║
echo ╚══════════════════════════════════════════════╝
echo.

:: Node.js kontrolü
echo [1/3] Node.js kontrol ediliyor...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js bulunamadı! Lütfen https://nodejs.org adresinden indirin.
    echo    LTS sürümünü indirip kurun, sonra bu scripti tekrar çalıştırın.
    pause
    exit /b 1
)
echo ✅ Node.js bulundu!
node -v

:: n8n kontrolü
echo.
echo [2/3] n8n kontrol ediliyor...
n8n --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ⏳ n8n bulunamadı, kuruluyor...
    npm install -g n8n
    if %errorlevel% neq 0 (
        echo ❌ n8n kurulumu başarısız! İnternet bağlantınızı kontrol edin.
        pause
        exit /b 1
    )
)
echo ✅ n8n bulundu!
n8n --version

:: FFmpeg kontrolü
echo.
echo [3/3] FFmpeg kontrol ediliyor...
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  FFmpeg bulunamadı! Video oluşturma için FFmpeg gerekli.
    echo    İndirme: https://ffmpeg.org/download.html
    echo    veya: winget install ffmpeg
    echo.
    echo    FFmpeg kurulduktan sonra bu scripti tekrar çalıştırın.
) else (
    echo ✅ FFmpeg bulundu!
)

echo.
echo ╔══════════════════════════════════════════════╗
echo ║  Kurulum Tamamlandı! ✅                       ║
echo ║  n8n'i başlatmak için start-n8n.bat           ║
echo ║  dosyasına çift tıklayın.                     ║
echo ╚══════════════════════════════════════════════╝
echo.
pause
