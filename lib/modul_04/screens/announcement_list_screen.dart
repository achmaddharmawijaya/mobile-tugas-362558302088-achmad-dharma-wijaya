import 'package:flutter/material.dart';
import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});
  final AnnouncementApi? api;
  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const _kategori = ['Semua', 'Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'];
  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();
  late Future<List<Announcement>> _futurePengumuman;
  String _kategoriTerpilih = 'Semua';
  String _query = '';
  int _percobaan = 0;
  bool _sedangMenyegarkan = false;

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final futureBaru = _api.ambilPengumuman();
    if (mounted) {
      setState(() {
        _futurePengumuman = futureBaru;
        _percobaan++;
      });
    }
    try { await futureBaru; } catch (_) {}
  }

  Future<void> _refreshTanpaMenggantiLayar() async {
    setState(() => _sedangMenyegarkan = true);
    final futureBaru = _api.ambilPengumuman();
    try {
      final data = await futureBaru;
      if (!mounted) return;
      setState(() {
        _futurePengumuman = Future<List<Announcement>>.value(data);
        _sedangMenyegarkan = false;
        _percobaan++;
      });
    } catch (_) {
      if (mounted) setState(() => _sedangMenyegarkan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal Pengumuman TRPL ($_percobaan)'),
        actions: [IconButton(onPressed: _muatUlang, icon: const Icon(Icons.refresh), tooltip: 'Segarkan Data')],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
          child: TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: 'Cari judul pengumuman', border: OutlineInputBorder()),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        SizedBox(
          height: 58,
          child: ListView.separated(
            padding: const EdgeInsets.all(10), scrollDirection: Axis.horizontal,
            itemCount: _kategori.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (_, i) => ChoiceChip(
              label: Text(_kategori[i]), selected: _kategoriTerpilih == _kategori[i],
              onSelected: (_) => setState(() => _kategoriTerpilih = _kategori[i]),
            ),
          ),
        ),
        if (_sedangMenyegarkan) const LinearProgressIndicator(minHeight: 2),
        Expanded(child: FutureBuilder<List<Announcement>>(
          future: _futurePengumuman,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return _memuat();
            if (snapshot.hasError) return _gagal(snapshot.error!);
            final semua = snapshot.data ?? const <Announcement>[];
            final tampil = semua.where((item) {
              final cocokKategori = _kategoriTerpilih == 'Semua' || item.category.toLowerCase() == _kategoriTerpilih.toLowerCase();
              final cocokJudul = item.title.toLowerCase().contains(_query.toLowerCase());
              return cocokKategori && cocokJudul;
            }).toList(growable: false);
            if (tampil.isEmpty) return _kosong();
            return RefreshIndicator(
  onRefresh: _refreshTanpaMenggantiLayar,
  child: ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: tampil.length,
    itemBuilder: (_, i) {
      return AnnouncementCard(
        announcement: tampil[i],
        onTap: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (_) => AnnouncementDetailScreen(
                announcement: tampil[i],
                allAnnouncements: semua,
              ),
            ),
          );
        },
      );
    },
  ),
);
          },
        )),
      ]),
    );
  }

  Widget _memuat() => const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 12), Text('Memuat pengumuman dari server...')]));
  Widget _gagal(Object error) => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.cloud_off, size: 64), const SizedBox(height: 12), const Text('Gagal Memuat Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(error.toString().replaceFirst('Exception: ', ''), textAlign: TextAlign.center), const SizedBox(height: 16), ElevatedButton.icon(onPressed: _muatUlang, icon: const Icon(Icons.refresh), label: const Text('Coba Lagi'))])));
  Widget _kosong() => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.inbox_outlined, size: 64), const SizedBox(height: 12), Text('Tidak ada pengumuman untuk kategori "$_kategoriTerpilih" dengan pencarian "$_query".', textAlign: TextAlign.center)]));
}
