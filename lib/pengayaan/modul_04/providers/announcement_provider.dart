import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../modul_04/models/announcement.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/announcement_repository_impl.dart';
import '../repositories/sample_announcement_repository.dart';

final useSampleDataProvider = Provider<bool>((ref) => false);
final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) => ref.watch(useSampleDataProvider) ? SampleAnnouncementRepository() : AnnouncementRepositoryImpl());
class SelectedCategory extends Notifier<String> { @override String build() => 'Semua'; void select(String value) => state = value; }
final selectedCategoryProvider = NotifierProvider<SelectedCategory, String>(SelectedCategory.new);
final announcementsProvider = FutureProvider<List<Announcement>>((ref) async { final repo = ref.watch(announcementRepositoryProvider); return repo.getAnnouncements(category: ref.watch(selectedCategoryProvider)); });
