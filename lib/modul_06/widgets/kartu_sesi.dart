
import 'package:flutter/material.dart';

import '../models/sesi_pengguna.dart';

class KartuSesi extends StatelessWidget {
  final SesiPengguna sesi;
  final DateTime sekarang;
  final VoidCallback? onKeluar;
  final bool sedangKeluar;
  final bool tampilkanToken;

  const KartuSesi({
    super.key,
    required this.sesi,
    required this.sekarang,
    this.onKeluar,
    this.sedangKeluar = false,
    this.tampilkanToken = false,
  });

  static String samarkanToken(String token) {
    if (token.isEmpty) return '(kosong)';
    if (token.length <= 6) return _titik(token.length);
    return '${token.substring(0, 6)}${_titik(12)}';
  }

  static String _titik(int jumlah) =>
      List<String>.filled(jumlah, '\u2022').join();

  static String formatWaktu(String iso) {
    const List<String> bulan = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];

    final DateTime? waktu = DateTime.tryParse(iso);
    if (waktu == null) return 'Tidak diketahui';

    final String jam = waktu.hour.toString().padLeft(2, '0');
    final String menit = waktu.minute.toString().padLeft(2, '0');

    return '${waktu.day} ${bulan[waktu.month - 1]} '
        '${waktu.year}, $jam:$menit';
  }

  static String formatSisa(Duration sisa) {
    if (sisa.inSeconds <= 0) return 'Sudah berakhir';
    if (sisa.inMinutes < 1) return '${sisa.inSeconds} detik';
    if (sisa.inHours < 1) return '${sisa.inMinutes} menit';

    final int menit = sisa.inMinutes.remainder(60);

    return menit == 0
        ? '${sisa.inHours} jam'
        : '${sisa.inHours} jam $menit menit';
  }

  @override
  Widget build(BuildContext context) {
    final bool kedaluwarsa =
        sesi.sisaWaktu(sekarang).inSeconds <= 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 42,
            ),
            const SizedBox(height: 12),
            Text(
              'Login Berhasil',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              sesi.nama,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(sesi.email),
            const SizedBox(height: 8),
            Chip(label: Text(SesiPengguna.labelPeran(sesi.peran))),
            const Divider(height: 28),
            const Text('Waktu masuk'),
            Text(formatWaktu(sesi.masukPada)),
            const SizedBox(height: 12),
            const Text('Kedaluwarsa pada'),
            Text(formatWaktu(sesi.kedaluwarsaPada)),
            const SizedBox(height: 12),
            const Text('Sisa masa sesi'),
            Text(formatSisa(sesi.sisaWaktu(sekarang))),
            const SizedBox(height: 12),
            const Text('Token sesi'),
            SelectableText(
              tampilkanToken
                  ? sesi.token
                  : samarkanToken(sesi.token),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed:
                    sedangKeluar || onKeluar == null ? null : onKeluar,
                icon: sedangKeluar
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.logout),
                label: Text(
                  sedangKeluar ? 'Sedang keluar...' : 'Keluar',
                ),
              ),
            ),
            if (kedaluwarsa)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Sesi ini sudah kedaluwarsa.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
