PROJECT_NAME: Habbist Share - Jurnal Kebiasaan Baik

TUJUAN_PROYEK:
  Membangun sistem jurnal digital untuk membentuk kebiasaan baik
  dan karakter siswa secara berkelanjutan.
  Dimulai dari jenjang Sekolah Dasar, dengan rencana pengembangan
  ke SMP, SMA, dan Mahasiswa.

KONTEKS_PENGGUNAAN:
  Digunakan di Rumah Belajar (SC).
  Selaras dengan program Kemendiknas tentang pembentukan
  7 Kebiasaan Baik.

KONSEP_UTAMA:
  - Sistem berbasis pembiasaan (habit-based system)
  - Aktivitas dilakukan setiap hari
  - Memiliki 7 kebiasaan utama sebagai tujuh pilar karakter
  - Berlaku selama 6 tahun jenjang SD
  - Materi sama, tetapi bobot, target, dan evaluasi berbeda
    sesuai tingkat kelas

STRUKTUR_PENGGUNA:
  ROLE:
    - Siswa
    - Mentor (Guru)
    - Orang Tua
    - Admin

  AKSES_ROLE:
    Siswa:
      - Mengisi jurnal kebiasaan harian
      - Tidak bisa mengubah kebiasaan custom
      - Bisa konsultasi melalui catatan

    Mentor:
      - Menentukan target kebiasaan
      - Membuat kebiasaan custom (karakter ke-8)
      - Memantau perkembangan siswa
      - Memiliki catatan harian privat per siswa
      - Menandai keberhasilan atau kegagalan

    Orang_Tua:
      - Login dan melihat perkembangan anak
      - Dilibatkan saat penentuan target kebiasaan

    Admin:
      - Akses penuh sistem
      - Manajemen pengguna, kelas, dan kebiasaan

STRUKTUR_SEKOLAH:
  - Sekolah
  - Kelas
  - Siswa

  KELOMPOK_KELAS:
    - Kelas 1–3
    - Kelas 4–6

SISTEM_KEBIASAAN:
  JUMLAH_KEBIASAAN_UTAMA: 7

  KARAKTER_KE-7:
    - Berlaku untuk semua kelas
    - Dikerjakan setiap hari
    - Memiliki:
        - Aturan waktu
        - Aturan frekuensi (harian / mingguan)
        - Bobot nilai
        - Perhitungan mingguan dan bulanan

  CONTOH_KEBIASAAN:
    Bangun_Pagi:
      - Memiliki jam target (contoh: 05.00)
      - Keterlambatan dibatasi
      - Tidak mengisi = otomatis gagal

ATURAN_PENGISIAN:
  - Sebagian kebiasaan diisi harian
  - Sebagian kebiasaan diakumulasi mingguan
  - Semua kebiasaan memiliki perhitungan progres

SUB_KEBIASAAN_BERDASARKAN_KELAS:
  Kelas_1-2:
    - Menentukan dan mematuhi jam bangun pagi

  Kelas_3-4:
    - Bangun pagi
    - Doa syukur
    - Membaca Alkitab (aturan tetap)

  Kelas_4-6:
    - Pola serupa dengan bobot lebih tinggi
    - Evaluasi lebih ketat

KEBIASAAN_IBADAH:
  - Menyesuaikan jenjang kelas
  - Contoh:
      - Ibadah gereja
      - Sekolah minggu
      - Ibadah hari Minggu
  - Aturan dan evaluasi berbeda per kelompok kelas

KARAKTER_KE-8 (CUSTOM):
  - Ditentukan oleh Mentor
  - Siswa tidak dapat memilih atau mengubah
  - Target ditentukan melalui diskusi Mentor dan Orang Tua
  - Contoh:
      - Berdoa setelah bangun
      - Merapikan tempat tidur

  FITUR_MENTOR:
    - Catatan harian privat per siswa
    - Riwayat gagal atau berhasil
    - Monitoring perkembangan jangka panjang

KONDISI_EMOSI_HARIAN:
  - Setiap hari siswa mengisi kondisi suasana hati
  - Ditampilkan di bagian akhir jurnal harian
  - Digunakan mentor untuk memahami kondisi emosional siswa

ANALITIK_DAN_LAPORAN:
  - Perhitungan kebiasaan mingguan
  - Grafik mingguan dan bulanan
  - Dashboard:
      - Per siswa
      - Per kelas
      - Per mentor

CATATAN_PENGEMBANGAN:
  - Sistem bersifat scalable ke jenjang lebih tinggi
  - Logika kebiasaan harus fleksibel dan berbasis aturan
  - Fokus utama pada pembentukan karakter, bukan sekadar checklist
