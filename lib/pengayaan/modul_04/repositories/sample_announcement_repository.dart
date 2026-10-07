import '../../../modul_04/models/announcement.dart';
import 'announcement_repository.dart';
class SampleAnnouncementRepository implements AnnouncementRepository {
  final List<Announcement> _items = List<Announcement>.of(Announcement.getSampleAnnouncements());
  @override Future<List<Announcement>> getAnnouncements({String? category}) async { await Future<void>.delayed(const Duration(milliseconds: 300)); if (category == null || category == 'Semua') return List<Announcement>.of(_items); return _items.where((e) => e.category.toLowerCase() == category.toLowerCase()).toList(); }
  @override Future<Announcement> addAnnouncement(Announcement announcement) async { _items.add(announcement); return announcement; }
}
