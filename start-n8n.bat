@echo off
set N8N_ENABLE_NODE_EXECUTE_COMMAND=true
set NODE_FUNCTION_ALLOW_EXTERNAL=*
set NODE_FUNCTION_ALLOW_BUILTIN=*
set WEBHOOK_URL=https://shorts-bot-2026.loca.lt
echo [Bilgi] Telegram t?neli ayarlanip n8n baslatiliyor...
start /B npx -y localtunnel --port 5678 --subdomain shorts-bot-2026
n8n