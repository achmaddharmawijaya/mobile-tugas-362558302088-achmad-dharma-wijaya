import 'package:flutter/material.dart';

import 'models/course.dart';
import 'widgets/course_card.dart';

class AcademicDashboardScreen extends StatelessWidget {
  const AcademicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = Course.getSampleCourses();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Ruang Praktikum Hari Ini',
          style: TextStyle(
            color: Color(0xFF17213D),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 28 : 16,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge informasi
              
Wrap(
  spacing: 10,
  runSpacing: 8,
  children: [
    _InfoBadge(
      icon: Icons.calendar_month,
      text: '3 sesi',
      iconColor: Colors.blue,
      backgroundColor: const Color(0xFFE0F2FE),
    ),
    _InfoBadge(
      icon: Icons.meeting_room,
      text: '1 ruang tersedia',
      iconColor: Colors.green,
      backgroundColor: const Color(0xFFDCFCE7),
    ),
  ],
),
                const SizedBox(height: 18),

                // Layout responsive
                if (!isTablet)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: courses[index],
                      );
                    },
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.65,
                    ),
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: courses[index],
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color backgroundColor;

  const _InfoBadge({
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: iconColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}