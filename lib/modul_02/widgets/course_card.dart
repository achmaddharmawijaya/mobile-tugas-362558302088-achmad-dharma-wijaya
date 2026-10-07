import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  Color _statusColor() {
    switch (course.status) {
      case 'Berlangsung':
        return Colors.blue;
      case 'Akan datang':
        return Colors.orange;
      case 'Selesai':
        return Colors.grey;
      case 'Tersedia':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  IconData _statusIcon() {
    switch (course.status) {
      case 'Berlangsung':
        return Icons.people;
      case 'Akan datang':
        return Icons.access_time;
      case 'Selesai':
        return Icons.check_circle;
      case 'Tersedia':
        return Icons.meeting_room;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama + Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17213D),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      course.status,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Kode
            Text(
              course.code,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

Text(
  'Dosen Penguji',
  style: TextStyle(
    color: Colors.blueGrey.shade700,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  ),
),

            const SizedBox(height: 4),

            // Waktu
            if (course.time.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.blueGrey.shade700,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      course.time,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 3),

            // Ruangan
            if (course.room.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey.shade700,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      course.room,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),

            // Deskripsi
            if (course.description.isNotEmpty) ...[
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Icon(
                      _statusIcon(),
                      size: 15,
                      color: statusColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        course.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 5),

            // SKS + Progress
  
            // Progress bar

          ],
        ),
      ),
    );
  }
}