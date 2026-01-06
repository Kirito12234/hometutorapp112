import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/course.dart';
import '../widgets/lesson_list_item.dart';
import '../../../dashboard/domain/entities/lesson.dart';

class CoursePlayerPage extends StatefulWidget {
  const CoursePlayerPage({Key? key}) : super(key: key);

  @override
  State<CoursePlayerPage> createState() => _CoursePlayerPageState();
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  bool _isPlaying = false;
  double _progress = 0.4; // 4:10 / 6:10

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
  
  String formatPrice(double price) {
    return 'RS ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              const Text(
                'Course data not found',
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
    
    final courseArg = args['course'];
    final lessonArg = args['lesson'];
    
    if (courseArg == null || courseArg is! Course || lessonArg == null || lessonArg is! Lesson) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              const Text(
                'Invalid course data',
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
    
    final Course course = courseArg;
    final Lesson currentLesson = lessonArg;


    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Video Player Section
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 100,
                    color: AppColors.buttonText.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 24,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              formatTime((currentLesson.durationMinutes * 60 * _progress).toInt()),
                              style: const TextStyle(
                                color: AppColors.buttonText,
                                fontSize: 12,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: _progress,
                                activeColor: AppColors.durationOrange,
                                inactiveColor: AppColors.textLight,
                                onChanged: (value) {
                                  setState(() {
                                    _progress = value;
                                  });
                                },
                              ),
                            ),
                            Text(
                              formatTime(currentLesson.durationMinutes * 60),
                              style: const TextStyle(
                                color: AppColors.buttonText,
                                fontSize: 12,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(
                                Icons.fullscreen,
                                color: AppColors.buttonText,
                              ),
                              onPressed: () {
                                // Handle fullscreen
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
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
                        formatPrice(course.price),
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
                    '${course.durationHours}h ${(course.durationHours * 60) % 60}min · ${course.lessonCount} Lessons',
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
                    child: Icon(
                      Icons.expand_more,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...course.lessons.map((lesson) {
                    return LessonListItem(
                      lesson: lesson,
                      isPlaying: lesson.id == currentLesson.id && _isPlaying,
                      onTap: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                    );
                  }),
                ],
              ),
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
                      // Handle buy now
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

