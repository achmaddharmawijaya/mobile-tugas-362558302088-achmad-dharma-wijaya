import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/announcement.dart';

class AnnouncementApi {
  AnnouncementApi({http.Client? client, this.modeSimulasi = false})
      : _client = client ?? http.Client(),
        _milikSendiri = client == null;

  final http.Client _client;
  final bool _milikSendiri;
  final bool modeSimulasi;

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration batasWaktu = Duration(seconds: 10);

  Future<List<Announcement>> ambilPengumuman() async {
    if (modeSimulasi) {
      await Future<void>.delayed(const Duration(seconds: 1));
      return Announcement.getSampleAnnouncements();
    }

    final http.Response response;
    try {
      response = await _client
          .get(Uri.parse('$baseUrl/posts?_limit=10'))
          .timeout(batasWaktu);
    } on TimeoutException {
      throw Exception('Koneksi ke server timeout. Periksa sambungan internet Anda.');
    } on http.ClientException {
      throw Exception('Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.');
    }

    if (response.statusCode != 200) {
      throw Exception('Server merespons dengan status ${response.statusCode}.');
    }

    final List<dynamic> baris;
    try {
      baris = jsonDecode(response.body) as List<dynamic>;
    } on FormatException {
      throw Exception('Respons server bukan JSON yang valid.');
    }

    const kategori = ['Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'];
    return List<Announcement>.generate(baris.length, (i) {
      final json = Map<String, dynamic>.from(baris[i] as Map);
      json['category'] ??= kategori[i % kategori.length];
      json['author'] ??= 'Admin Jurusan';
      json['date'] ??= '2026-09-${(i + 1).toString().padLeft(2, '0')}';
      json['readCount'] ??= (i + 1) * 25;
      return Announcement.fromJson(json);
    });
  }

  void tutup() {
    if (_milikSendiri) _client.close();
  }
}
