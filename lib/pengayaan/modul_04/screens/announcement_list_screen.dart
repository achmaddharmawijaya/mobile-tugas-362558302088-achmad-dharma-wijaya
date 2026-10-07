import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../modul_04/models/announcement.dart';
import '../providers/announcement_provider.dart';

class PengayaanListScreen extends ConsumerWidget {
  const PengayaanListScreen({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(announcementsProvider);
    final category = ref.watch(selectedCategoryProvider);
    const categories = ['Semua', 'Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'];
    return Scaffold(appBar: AppBar(title: const Text('Portal Pengumuman — Fase B'), actions: [IconButton(onPressed: () => ref.invalidate(announcementsProvider), icon: const Icon(Icons.refresh))]), body: Column(children: [SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: categories.map((c) => Padding(padding: const EdgeInsets.all(4), child: ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => ref.read(selectedCategoryProvider.notifier).select(c)))).toList())), Expanded(child: async.when(loading: () => const Center(child: CircularProgressIndicator()), error: (e, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(e.toString()), ElevatedButton(onPressed: () => ref.invalidate(announcementsProvider), child: const Text('Coba Lagi'))])), data: (items) => items.isEmpty ? const Center(child: Text('Tidak ada data')) : ListView.builder(itemCount: items.length, itemBuilder: (_, i) => ListTile(title: Text(items[i].title), subtitle: Text(items[i].category)))))]));
  }
}
