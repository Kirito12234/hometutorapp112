import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/course.dart';
import '../widgets/lesson_list_item.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({Key? key}) : super(key: key);

  String _formatPrice(double price) {
    return 'RS ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Course) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              const Text(
                'Course not found',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    final Course course = args;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Header Section
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.headerPink,
                        AppColors.headerPink.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 24,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      if (course.isBestseller)
                        Positioned(
                          top: 100,
                          left: 24,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bestsellerYellow,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              'BESTSELLER',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                                fontFamily: 'Inter',
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 40,
                        left: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 24,
                        bottom: 60,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.primary.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 24,
                        child: Row(
                          children: [
                            Icon(
                              Icons.send,
                              size: 16,
                              color: AppColors.textPrimary.withOpacity(0.5),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 40,
                              height: 2,
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Section - Positioned to overlap
                Positioned(
                  top: 280,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            Text(
                              _formatPrice(course.price),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course.id == '1' 
                            ? '6h 14min · ${course.lessonCount} Lessons'
                            : '${course.durationHours}h ${((course.durationHours * 60) % 60).toString().padLeft(2, '0')}min · ${course.lessonCount} Lessons',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'About this course',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          course.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontFamily: 'Inter',
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundLight,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.expand_more,
                              color: AppColors.textLight,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ...course.lessons.map((lesson) {
                          return LessonListItem(
                            lesson: lesson,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.coursePlayer,
                                arguments: {
                                  'course': course,
                                  'lesson': lesson,
                                },
                              );
                            },
                          );
                        }),
                        const SizedBox(height: 100), // Space for bottom bar
                      ],
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.favoriteOrangeLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.favoriteOrange,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.star_outline,
                    color: AppColors.favoriteOrange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    text: 'Buy Now',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.paymentMethod);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

