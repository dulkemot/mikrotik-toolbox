# 02 - Failover 2 WAN (recursive routing)
# Cara kerja: masing-masing gateway dicek via IP publik (8.8.8.8 / 1.1.1.1).
# Route utama distance=1 mati otomatis kalau ping check gagal -> pindah ke backup.
#
# === VARIABEL: sesuaikan ===
:local wan1gw "192.168.1.1"
:local wan2gw "192.168.2.1"

/ip route add dst-address=8.8.8.8/32 gateway=$wan1gw scope=10 comment="cek-wan1"
/ip route add dst-address=1.1.1.1/32 gateway=$wan2gw scope=10 comment="cek-wan2"
/ip route add distance=1 gateway=8.8.8.8 check-gateway=ping comment="wan-utama"
/ip route add distance=2 gateway=1.1.1.1 check-gateway=ping comment="wan-backup"

:log info "Failover 2 WAN terpasang"
