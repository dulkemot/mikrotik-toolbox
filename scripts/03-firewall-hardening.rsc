# 03 - Firewall hardening baseline
# Aturan input chain: terima established/related, tolak invalid,
# izinkan dari LAN + VPN, tolak sisanya.
# PENTING: pastikan kamu akses dari IP LAN saat apply, atau izinkan IP admin dulu!
#
# === VARIABEL: sesuaikan ===
:local lan "192.168.88.0/24"
:local wgPort "13231"

/ip firewall filter
add chain=input action=accept connection-state=established,related,untracked comment="terima koneksi jadi"
add chain=input action=drop connection-state=invalid comment="buang invalid"
add chain=input action=accept src-address=$lan comment="izin LAN"
add chain=input action=accept protocol=udp dst-port=$wgPort comment="izin WireGuard"
add chain=input action=drop comment="tolak sisanya"

# Matikan service yang tidak dipakai
/ip service disable telnet,ftp,www,api,api-ssl

# Ganti password admin default!
# /user set admin password="GANTI-DENGAN-PASSWORD-KUAT"

:log info "Firewall hardening terpasang"
