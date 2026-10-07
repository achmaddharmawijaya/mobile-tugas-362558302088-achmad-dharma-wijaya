import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/announcement_provider.dart';
import 'screens/announcement_list_screen.dart';

const bool kUseSampleData = bool.fromEnvironment('USE_SAMPLE_DATA');
class Modul04PengayaanApp extends StatelessWidget {
  const Modul04PengayaanApp({super.key});
  @override
  Widget build(BuildContext context) => ProviderScope(overrides: [useSampleDataProvider.overrideWithValue(kUseSampleData)], child: MaterialApp(title: 'Modul 04 Fase B', theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7))), home: const PengayaanListScreen()));
}
