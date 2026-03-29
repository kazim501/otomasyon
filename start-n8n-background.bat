@echo off
chcp 65001 >nul 2>&1
title n8n - PM2 Arka Plan Servisi

echo ╔══════════════════════════════════════════════╗
echo ║  n8n Arka Planda Baslatiliyor (PM2)           ║
echo ╚══════════════════════════════════════════════╝
echo.

:: PM2 ile n8n'i başlat
echo [1/2] n8n arka planda baslatiliyor...
call npx -y pm2 start n8n --name "n8n-shorts"
echo.

:: PM2 durumunu kaydet
echo [2/2] PM2 durumu kaydediliyor...
call npx -y pm2 save
echo.

echo ╔══════════════════════════════════════════════╗
echo ║  n8n arka planda calisiyor! ✅                ║
echo ║                                               ║
echo ║  Tarayicida: http://localhost:5678             ║
echo ║                                               ║
echo ║  Faydali komutlar:                             ║
echo ║  npx pm2 status     - Durum kontrolu           ║
echo ║  npx pm2 logs n8n-shorts - Loglari gor         ║
echo ║  npx pm2 stop n8n-shorts - Durdur               ║
echo ║  npx pm2 restart n8n-shorts - Yeniden baslat    ║
echo ╚══════════════════════════════════════════════╝
echo.
pause
