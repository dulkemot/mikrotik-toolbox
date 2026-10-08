# MikroTik Toolbox 🇮🇩

Kumpulan script RouterOS siap pakai untuk operasional ISP / enterprise / hospitality: backup otomatis, failover 2 WAN, firewall hardening, monitoring Netwatch + alert Telegram, dan WireGuard road-warrior.

> ⚠️ Template — sesuaikan IP, interface, dan token sebelum dipakai produksi. Uji dulu di lab / CHR.

![RouterOS](https://img.shields.io/badge/RouterOS-7.x-ff8a00?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

## Isi

| Script | Fungsi |
|---|---|
| `scripts/01-backup-otomatis.rsc` | Backup binary + export config tiap hari via scheduler |
| `scripts/02-failover-2-wan.rsc` | Failover recursive routing (cek 8.8.8.8 / 1.1.1.1) |
| `scripts/03-firewall-hardening.rsc` | Baseline filter input + matikan service tak perlu |
| `scripts/04-netwatch-telegram.rsc` | Alert Telegram saat host up/down |
| `scripts/05-wireguard-roadwarrior.rsc` | VPN WireGuard untuk admin/teknisi lapangan |

## Cara pakai

1. Buka WinBox / WebFig → **Terminal**, atau SSH ke router.
2. Copy isi script, ganti bagian `VARIABEL` di atas (interface WAN, gateway, token bot).
3. Paste ke terminal, atau upload sebagai `.rsc` lalu:
```
/import file-name=02-failover-2-wan.rsc
```

## Contoh: failover 2 WAN

```routeros
# Ganti sesuai topologimu
:local wan1gw "192.168.1.1"
:local wan2gw "192.168.2.1"

/ip route add dst-address=8.8.8.8/32 gateway=$wan1gw scope=10 comment="cek-wan1"
/ip route add dst-address=1.1.1.1/32 gateway=$wan2gw scope=10 comment="cek-wan2"
/ip route add distance=1 gateway=8.8.8.8 check-gateway=ping comment="main"
/ip route add distance=2 gateway=1.1.1.1 check-gateway=ping comment="backup"
```

Prinsip: route utama mati otomatis saat ping check gagal, traffic pindah ke backup.

## Kontribusi

PR dipersilakan — terutama script QoS hotel, hotspot voucher, dan traffic monitor.

MIT — dulkemot 2026
