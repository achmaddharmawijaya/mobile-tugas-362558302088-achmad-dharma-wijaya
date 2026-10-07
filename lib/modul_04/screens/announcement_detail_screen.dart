import 'package:flutter/material.dart';
import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key, required this.announcement, this.allAnnouncements = const []});
  final Announcement announcement;
  final List<Announcement> allAnnouncements;

  @override
  Widget build(BuildContext context) {
    final jumlahKategori = allAnnouncements.where((e) => e.category == announcement.category).length;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengumuman')),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Chip(label: Text(announcement.category)),
        const SizedBox(height: 12),
        Text(announcement.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('${announcement.author} • ${announcement.date} • Dibaca ${announcement.readCount} kali'),
        const Divider(height: 32),
        Text(announcement.content, style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 20),
        Card(child: ListTile(leading: const Icon(Icons.category), title: const Text('Ringkasan kategori'), subtitle: Text('$jumlahKategori pengumuman dalam kategori ${announcement.category}.'))),
      ])),
    );
  }
}
