# Modul 04 — Future & REST API Dasar (Bagian 1–7)

## Bagian 1 — Konsep Dasar

### 4.1 Kenapa data internet tidak langsung tampil?
Data jaringan datang setelah widget dibuat. Karena itu UI harus menangani kondisi ketika data belum tersedia, gagal, kosong, atau berhasil.

### 4.2 Future
`Future<T>` adalah nilai yang belum tersedia sekarang tetapi akan tersedia atau gagal kemudian. `async` dan `await` dipakai untuk membaca hasil tanpa membekukan UI.

### 4.3 Empat keadaan UI
1. Loading — Future belum selesai.
2. Error — Future selesai dengan error.
3. Empty — data selesai tetapi daftar kosong.
4. Success — data tersedia dan ditampilkan.

### 4.4 HTTP
Request Fase A menggunakan GET ke `https://jsonplaceholder.typicode.com/posts?_limit=10`. Response harus berstatus 200. Timeout dan kesalahan koneksi ditampilkan sebagai pesan yang berbeda.

### 4.5 JSON → model
`Announcement.fromJson()` menerjemahkan JSON menjadi model Dart dan memberikan nilai cadangan jika field hilang. `body` juga diterima sebagai sumber `content`.

### 4.6 Future disimpan pada State
Future dibuat di `initState()`, bukan di `build()`. Refresh membuat Future baru hanya ketika memang diminta.

## Bagian 2 — Praktikum Fase A

Folder wajib:
- `lib/modul_04/models/announcement.dart`
- `lib/modul_04/services/announcement_api.dart`
- `lib/modul_04/widgets/announcement_card.dart`
- `lib/modul_04/screens/announcement_list_screen.dart`
- `lib/modul_04/screens/announcement_detail_screen.dart`
- `lib/modul_04/modul_04_app.dart`

Perintah:
```bash
flutter pub get
flutter run -t lib/modul_04/main.dart
flutter run -t lib/modul_04/main.dart --dart-define=SIMULASI=true
flutter analyze
flutter test test/modul_04_test.dart
```

## Bagian 3 — Konsep Lanjutan
- Repository memisahkan kontrak data dari sumber data.
- Dio menyederhanakan base URL, timeout, header, dan interceptor.
- Riverpod memindahkan state async keluar dari widget.
- Fase B memakai `FutureProvider` dan `AsyncValue`.

## Bagian 4 — Praktikum Fase B

Folder:
`lib/pengayaan/modul_04/`

Perintah:
```bash
flutter run -t lib/pengayaan/modul_04/main.dart
flutter run -t lib/pengayaan/modul_04/main.dart --dart-define=USE_SAMPLE_DATA=true
```

Fase B menggunakan Dio + Repository + Riverpod, sedangkan model tetap dipakai dari Fase A.

## Bagian 5 — Latihan Mandiri (selesai)

### Latihan 1 — Timeout
Batas timeout pada Fase A adalah 10 detik. Untuk eksperimen, ubah sementara menjadi 1 detik dan jalankan pada koneksi yang lambat. Timeout terjadi bila request tidak selesai dalam batas waktu; `ClientException` lebih berkaitan dengan kegagalan klien/koneksi.

### Latihan 2 — Penghitung percobaan
Sudah diterapkan sebagai `_percobaan` pada `AnnouncementListScreen` dan ditampilkan di AppBar. Nilainya bertambah ketika refresh/retry dijalankan.

### Latihan 3 — Pencarian judul
Sudah diterapkan melalui `TextField`. Penyaringan dilakukan dengan `where()` di `build()` dan tidak mengirim request baru.

### Latihan 4 — Keadaan sedang menyegarkan
Sudah diterapkan dengan `_sedangMenyegarkan` dan `LinearProgressIndicator`, sehingga pull-to-refresh tidak mengganti seluruh layar menjadi loading awal.

### Latihan 5 — Ringkasan kategori
Sudah diterapkan pada halaman detail. Jumlah pengumuman kategori dihitung dari data yang dikirim melalui konstruktor, tanpa request baru.

## Bagian 6 — Verifikasi & Kuis

Checklist:
- Loading dengan teks penjelas: ✓ kode tersedia
- Future di State: ✓
- Error dengan sebab: ✓
- Timeout dan ClientException dibedakan: ✓
- Status selain 200 ditolak: ✓
- Coba Lagi mengirim request baru: ✓
- Empty state: ✓
- Data server ditampilkan: ✓
- fromJson dengan fallback: ✓
- Filter kategori tanpa request baru: ✓
- http.Client ditutup di dispose: ✓
- Test Modul 04 tersedia: ✓

### Jawaban kuis
1. **B** — agar Future dan empat keadaan dapat diuji tanpa gangguan jaringan.
2. **B** — saat Future selesai dengan error.
3. **A** — Future dibuat ulang di dalam build().
4. **B** — widget tetap bekerja walau sumber data berganti ke data lokal.

## Bagian 7 — Tugas, Rubrik & Refleksi

### Tugas
Portal Pengumuman Fase A sudah dibuat dengan GET, timeout, empat state, retry, refresh, filter, detail, lifecycle client, dan test.

### Refleksi 1
Pada Fase A, filter kategori lebih mudah dipahami karena langsung terlihat di dalam `build()` dengan `where()`. Setelah berpindah ke repository, UI menjadi lebih bersih karena tidak perlu mengetahui cara data disaring. Kekurangannya, struktur aplikasi menjadi lebih banyak sehingga perlu memahami hubungan provider dan repository.

### Refleksi 2
`catch (e) { return []; }` buruk karena menyamarkan kegagalan jaringan sebagai data kosong. Pengguna tidak dapat membedakan server gagal dengan memang tidak ada data. Seharusnya error dilempar kembali dan ditampilkan pada error state dengan pesan yang membantu.

### Refleksi 3
Fase A hanya membaca sample list sehingga tidak perlu mengubah isinya. Pada Fase B, `SampleAnnouncementRepository` melakukan operasi seperti `add`, sehingga list perlu disalin dengan `List.of()` agar menjadi list yang dapat dimodifikasi.

### Refleksi 4
Retry otomatis berguna ketika kegagalan jaringan hanya sementara karena aplikasi dapat mencoba lagi tanpa tindakan pengguna. Namun retry dapat merugikan ketika endpoint sedang bermasalah atau kuota terbatas karena request berulang dapat memperpanjang waktu tunggu dan menambah beban server.

### Refleksi 5
FutureBuilder masih layak untuk aplikasi sederhana, tetapi jika endpoint hanya boleh dipanggil sekali sehari, Future harus disimpan dan hasilnya di-cache. Perubahan paling kecil adalah menambahkan penyimpanan hasil/timestamp sehingga request baru hanya dilakukan setelah cache kedaluwarsa.

## Bukti screenshot yang perlu dimasukkan ke README
1. Loading — jalankan dengan `--dart-define=SIMULASI=true`.
2. Error — gunakan endpoint yang sengaja salah atau matikan koneksi.
3. Empty — pilih kombinasi filter/pencarian yang tidak menghasilkan data.
4. Success — jalankan normal dan tampilkan daftar.

## Catatan
Kode ini mengikuti urutan pembelajaran codelab: Fase A di `lib/modul_04/` dan pengayaan Fase B di `lib/pengayaan/modul_04/`.
