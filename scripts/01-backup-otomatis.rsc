# 01 - Backup otomatis harian
# Membuat file backup (.backup) + export config (.rsc) dengan tanggal,
# lalu membuat scheduler agar jalan tiap jam 02:00.
# Ganti STORAGE bila perlu (default: flash/internal).

:local date [/system clock get date]
:local name ("backup-" . $date)

/system backup save name=$name
/export file=$name
:log info ("Backup selesai: " . $name)

/system scheduler add name="backup-harian" start-time=02:00:00 interval=1d \
  on-event=("/system backup save name=(\"backup-\" . [/system clock get date]); /export file=(\"backup-\" . [/system clock get date])") \
  comment="backup otomatis harian"
