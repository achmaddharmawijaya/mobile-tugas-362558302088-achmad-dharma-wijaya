https://github.com/achmaddharmawijaya/mobile-tugas-362558302088-achmad-dharma-w.
aporan Praktikum Modul 01: Mobile Ecosystem, Flutter Setup & Profile App
Nama: Achmad Dharma Wijaya
NIM: 362558302088
Kelas / Prodi: 2D / Sarjana Terapan TRPL
Mata Kuliah: Pemrograman Perangkat Bergerak (Semester 3)
1. Ringkasan Aktivitas
Pada praktikum Modul 02, saya mempelajari dasar-dasar Mobile Ecosystem, pengenalan Flutter, serta proses melakukan setup lingkungan pengembangan aplikasi mobile. Saya mempelajari bagaimana Flutter digunakan untuk membuat aplikasi mobile dengan satu basis kode dan memahami beberapa komponen dasar yang digunakan dalam pengembangan aplikasi Flutter.
Selain melakukan setup Flutter, saya juga membuat dan menjalankan Profile App yang menampilkan informasi mahasiswa. Dalam proses pengerjaan, saya menggunakan VS Code sebagai code editor dan melakukan pengecekan project menggunakan beberapa perintah Flutter seperti flutter pub get, flutter analyze, flutter doctor, dan flutter run. Saya juga mempelajari cara membaca pesan error atau warning yang muncul ketika melakukan analisis kode.
2. Bukti Tangkapan Layar (Running App)
Pada bagian ini, masukkan minimal 2 screenshot ketika aplikasi Profile App sudah berhasil berjalan di Chrome, emulator Android, atau HP fisik.
![Screenshot Running 1](![alt text](foto_tugas/foto tugas modul 2.png))

![Screenshot Running 2](![alt text](foto_tugas/foto tugas modul 2.png))
Keterangan:
Screenshot Running 1: Menampilkan halaman utama/Profile App ketika aplikasi berhasil dijalankan.
Screenshot Running 2: Menampilkan bagian informasi profil mahasiswa atau tampilan lain dari aplikasi.
Kalau belum punya screenshot running, jalankan dulu aplikasinya dengan:
flutter run -d chrome
Setelah aplikasi tampil di Chrome, ambil screenshot dan masukkan ke folder screenshots.
3. Kendala yang Dihadapi & Solusinya
Kendala 1: flutter tidak ditemukan
Pada awal pengerjaan, terdapat kendala ketika menjalankan perintah Flutter karena terminal menampilkan:
zsh: command not found: flutter
Solusi:
Melakukan pengecekan instalasi Flutter dan memastikan Flutter SDK sudah terpasang serta PATH sudah dikonfigurasi dengan benar. Setelah konfigurasi selesai, perintah Flutter dapat digunakan melalui Terminal.
Kendala 2: Tidak ada perangkat yang dapat digunakan
Ketika menjalankan:
flutter run
muncul pesan:
No supported devices connected.
Flutter mendeteksi macOS dan Chrome, tetapi belum ada perangkat Android atau emulator yang terhubung.
Solusi:
Karena Chrome tersedia sebagai perangkat untuk Flutter Web, aplikasi dapat dijalankan menggunakan:
flutter run -d chrome
Alternatif lainnya adalah menghubungkan HP Android atau menjalankan Android Emulator.
Kendala 3: Android License Status Unknown
Pada saat menjalankan:
flutter doctor
terdapat peringatan mengenai Android license:
Android license status unknown.
Solusi:
Menjalankan perintah:
flutter doctor --android-licenses
Kemudian menyetujui lisensi Android SDK dengan memilih y pada setiap pertanyaan yang diberikan.
Kendala 4: withOpacity deprecated
Ketika menjalankan:
flutter analyze
terdapat informasi:
'withOpacity' is deprecated and shouldn't be used.
Hal tersebut terjadi karena versi Flutter/Dart yang digunakan sudah menyarankan penggunaan withValues() sebagai pengganti withOpacity().
Solusi:
Kode seperti:
Colors.white.withOpacity(0.2)
dapat diperbarui menjadi:
Colors.white.withValues(alpha: 0.2)
Contoh lainnya:
const Color(0xFF0284C7).withOpacity(0.3)
diubah menjadi:
const Color(0xFF0284C7).withValues(alpha: 0.3)
Kendala ini termasuk deprecated warning, bukan kesalahan fatal yang secara langsung menyebabkan aplikasi tidak dapat dijalankan.
Kendala 5: Terdapat beberapa issue ketika flutter analyze
Setelah menjalankan:
flutter analyze
terdapat beberapa informasi mengenai penggunaan withOpacity yang sudah deprecated.
Solusi:
Memeriksa file dan baris kode yang ditunjukkan oleh hasil flutter analyze, kemudian mengganti penggunaan API yang sudah deprecated dengan API yang direkomendasikan oleh Flutter, yaitu withValues().
Setelah melakukan perubahan, perintah berikut dapat digunakan kembali untuk memastikan kode sudah lebih baik:
flutter analyze
4. Jawaban Pertanyaan Refleksi
1. Pilihan Native vs Flutter
Saya memilih Flutter karena Flutter memungkinkan pengembangan aplikasi untuk beberapa platform menggunakan satu basis kode. Dengan Flutter, developer dapat membuat aplikasi Android, iOS, dan Web tanpa harus membuat seluruh kode dari awal untuk setiap platform.
Flutter juga menyediakan banyak widget siap pakai sehingga proses pembuatan antarmuka menjadi lebih mudah. Selain itu, fitur Hot Reload membantu developer melihat perubahan kode dengan cepat tanpa harus menjalankan ulang aplikasi dari awal.
Namun, pengembangan Native tetap memiliki kelebihan, terutama ketika aplikasi membutuhkan akses yang sangat spesifik terhadap fitur perangkat atau membutuhkan performa yang sangat optimal pada platform tertentu.
2. Prinsip UI = f(state)
Prinsip UI = f(state) berarti tampilan antarmuka aplikasi bergantung pada kondisi atau state yang sedang dimiliki aplikasi.
Sebagai contoh, apabila sebuah aplikasi memiliki tombol yang mengubah status dari Belum Diverifikasi menjadi Sudah Diverifikasi, maka tampilan UI akan berubah sesuai dengan perubahan state tersebut.
Secara sederhana dapat digambarkan:
State berubah
     ↓
Flutter membangun kembali UI
     ↓
Tampilan aplikasi berubah
Dengan konsep ini, developer tidak perlu mengubah tampilan secara manual satu per satu. Developer cukup mengubah state, kemudian Flutter akan menyesuaikan tampilan berdasarkan state tersebut.
3. Pentingnya Conventional Commits
Conventional Commits penting karena membantu membuat pesan commit Git menjadi lebih terstruktur, konsisten, dan mudah dipahami.
Contohnya:
feat: menambahkan halaman profile mahasiswa
fix: memperbaiki tampilan profile
docs: memperbarui README praktikum
Beberapa tipe yang umum digunakan antara lain:
feat → menambahkan fitur baru
fix → memperbaiki bug
docs → perubahan dokumentasi
refactor → memperbaiki struktur kode tanpa mengubah fungsi
test → menambahkan atau memperbaiki pengujian
Dengan Conventional Commits, anggota kelompok maupun developer lain dapat mengetahui tujuan suatu perubahan hanya dari membaca pesan commit. Hal ini juga membuat riwayat Git/GitHub menjadi lebih rapi dan mudah ditelusuri.
Kesimpulan
Pada praktikum Modul 01, saya telah mempelajari dasar ekosistem aplikasi mobile dan framework Flutter, melakukan setup lingkungan pengembangan, serta membuat aplikasi Profile App sederhana. Saya juga mempelajari penggunaan perintah Flutter seperti flutter doctor, flutter pub get, flutter analyze, dan flutter run.
Selama praktikum terdapat beberapa kendala, seperti perangkat yang belum terhubung, Android license yang belum dikonfigurasi, serta penggunaan withOpacity yang sudah deprecated. Kendala tersebut dapat diatasi dengan melakukan konfigurasi environment, menggunakan Chrome sebagai perangkat untuk menjalankan aplikasi, serta memperbarui kode menggunakan API Flutter yang lebih baru.
Melalui praktikum ini, saya menjadi lebih memahami dasar pengembangan aplikasi menggunakan Flutter, konsep UI = f(state), serta pentingnya penggunaan Git dan Conventional Commits dalam pengelolaan project.
## Modul 04 — Future & REST API
Implementasi lengkap Modul 04 tersedia pada `lib/modul_04/` untuk Fase A dan `lib/pengayaan/modul_04/` untuk Fase B. Dokumentasi Bagian 1–7 ada di `MODUL_04_LENGKAP.md`.

Jalankan Fase A:
`flutter run -t lib/modul_04/main.dart`

Jalankan Fase B sample:
`flutter run -t lib/pengayaan/modul_04/main.dart --dart-define=USE_SAMPLE_DATA=true`
