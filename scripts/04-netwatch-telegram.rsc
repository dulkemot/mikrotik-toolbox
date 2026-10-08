# 04 - Netwatch + alert Telegram
# Pantau 1 host penting (misal gateway ISP / server). Kirim pesan Telegram saat down/up.
# Buat bot via @BotFather, ambil token + chat ID (via @userinfobot).
#
# === VARIABEL: sesuaikan ===
:local botToken "ISI-TOKEN-BOT"
:local chatId "ISI-CHAT-ID"
:local host "8.8.8.8"

/tool netwatch add host=$host interval=30s timeout=1000ms \
  up-script="/tool fetch url=\"https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=UP $host\" keep-result=no" \
  down-script="/tool fetch url=\"https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=DOWN $host - cek koneksi!\" keep-result=no" \
  comment="monitor-gateway"

:log info "Netwatch Telegram terpasang"
