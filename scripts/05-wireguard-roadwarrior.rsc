# 05 - WireGuard road-warrior (server di router)
# VPN untuk admin/teknisi akses router & LAN dari lapangan/HP.
# Setelah server jalan, tambahkan peer per perangkat (paste public key client).
#
# === VARIABEL: sesuaikan ===
:local wgPort "13231"
:local wgNet "10.99.99.1/24"
:local lan "192.168.88.0/24"

/interface wireguard add name=wg-admin listen-port=$wgPort comment="vpn-admin"
/ip address add address=$wgNet interface=wg-admin comment="vpn-admin"

/ip firewall filter add chain=input action=accept protocol=udp dst-port=$wgPort comment="izin WireGuard" place-before=([/ip firewall filter find comment="tolak sisanya"])

# Contoh tambah 1 peer (HP teknisi) — ganti PUBLIC-KEY & IP:
/interface wireguard peers add interface=wg-admin public-key="PUBLIC-KEY-HP" allowed-address=10.99.99.2/32 comment="hp-teknisi"

:log info "WireGuard server terpasang di port $wgPort"
