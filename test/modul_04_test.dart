import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:poliwangi_mobile_starter/modul_04/models/announcement.dart';
import 'package:poliwangi_mobile_starter/modul_04/services/announcement_api.dart';
import 'package:poliwangi_mobile_starter/modul_04/screens/announcement_list_screen.dart';

void main() {
  group('Modul 04 Fase A', () {
    test('fromJson memberi fallback saat field tidak lengkap', () {
      final a = Announcement.fromJson({'id': 1, 'title': 'Judul', 'body': 'Isi'});
      expect(a.title, 'Judul');
      expect(a.content, 'Isi');
      expect(a.author, 'Admin Jurusan');
      expect(a.category, 'Akademik');
      expect(a.readCount, 0);
    });

    test('API memetakan response JSON menjadi Announcement', () async {
      final client = MockClient((request) async => http.Response('[{"id":1,"title":"Tes","body":"Isi"}]', 200));
      final api = AnnouncementApi(client: client);
      final result = await api.ambilPengumuman();
      expect(result, hasLength(1));
      expect(result.first.title, 'Tes');
    });

    test('API menolak status selain 200', () async {
      final client = MockClient((request) async => http.Response('Server Error', 500));
      final api = AnnouncementApi(client: client);
      expect(api.ambilPengumuman(), throwsA(isA<Exception>()));
    });

    testWidgets('layar sukses menampilkan judul dan filter', (tester) async {
      final api = AnnouncementApi(modeSimulasi: true);
      await tester.pumpWidget(MaterialApp(home: AnnouncementListScreen(api: api)));
      expect(find.text('Memuat pengumuman dari server...'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Portal Pengumuman TRPL (0)'), findsOneWidget);
      expect(find.text('Akademik'), findsWidgets);
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}
