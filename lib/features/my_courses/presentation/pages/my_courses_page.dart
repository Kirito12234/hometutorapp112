import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../widgets/my_courses_header.dart';
import '../widgets/course_progress_tile.dart';
import '../../../dashboard/presentation/widgets/bottom_nav.dart';
import '../../../courses/data/dummy/dummy_courses.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  int _currentNavIndex = 0;

  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Product Design v1.0',
      'completed': 14,
      'total': 24,
      'cardColor': AppColors.favoriteOrangeLight,
      'progressColor': AppColors.durationOrange,
    },
    {
      'title': 'Java Development',
      'completed': 12,
      'total': 18,
      'cardColor': AppColors.categoryBlue,
      'progressColor': AppColors.primary,
    },
    {
      'title': 'Visual Design',
      'completed': 10,
      'total': 16,
      'cardColor': const Color(0xFFE0F7FA),
      'progressColor': const Color(0xFF00ACC1),
    },
    {
      'title': 'Mathmatics',
      'completed': 12,
      'total': 18,
      'cardColor': AppColors.categoryBlue,
      'progressColor': AppColors.primary,
    },
    {
      'title': 'web development',
      'completed': 10,
      'total': 16,
      'cardColor': AppColors.categoryBlue,
      'progressColor': AppColors.primary,
    },
    {
      'title': 'networking',
      'completed': 10,
      'total': 16,
      'cardColor': AppColors.categoryBlue,
      'progressColor': AppColors.primary,
    },
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(AppRoutes.courses);
        break;
      case 2:
        Navigator.of(context).pushNamed(AppRoutes.searchResults);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(AppRoutes.notifications);
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed(AppRoutes.account);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My courses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: Column(
        children: [
          const MyCoursesHeader(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return CourseProgressTile(
                  title: course['title'] as String,
                  completed: course['completed'] as int,
                  total: course['total'] as int,
                  cardColor: course['cardColor'] as Color,
                  progressColor: course['progressColor'] as Color,
                  onTap: () {
                    // Get the first course from dummy data that matches the title
                    final allCourses = DummyCourses.getCourses();
                    final matchingCourse = allCourses.firstWhere(
                      (c) => c.title.toLowerCase() == (course['title'] as String).toLowerCase(),
                      orElse: () => allCourses.first,
                    );
                    Navigator.of(context).pushNamed(
                      AppRoutes.courseDetail,
                      arguments: matchingCourse,
                    );
                  },
                );
              },
            ),
          ),
          BottomNav(
            currentIndex: _currentNavIndex,
            onTap: _onNavTap,
          ),
        ],
      ),
    );
  }
}

