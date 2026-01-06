import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../data/dummy/dummy_courses.dart';
import '../../domain/entities/course.dart';
import '../widgets/course_category_card.dart';
import '../widgets/course_list_item.dart';
import '../widgets/filter_sheet.dart';
import '../../../dashboard/presentation/widgets/bottom_nav.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int _currentNavIndex = 1;
  String _selectedFilter = 'All';
  final List<Course> _courses = DummyCourses.getCourses();

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterSheet(
        selectedCategories: [],
        onApply: (categories, duration, priceRange) {
          // Navigate to search results with filters
          Navigator.of(context).pushNamed(
            AppRoutes.searchResults,
            arguments: null,
          );
        },
      ),
    );
  }

  List<Course> get _filteredCourses {
    switch (_selectedFilter) {
      case 'Popular':
        return _courses.where((c) => c.isPopular).toList();
      case 'New':
        return _courses.where((c) => c.isNew).toList();
      default:
        return _courses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Course',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.buttonText,
              size: 20,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find Cousre',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          fontFamily: 'Inter',
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.tune,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: _showFilterSheet,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                CourseCategoryCard(
                  title: 'Languege',
                  backgroundColor: AppColors.categoryBlue,
                  tagColor: AppColors.background,
                ),
                CourseCategoryCard(
                  title: 'Music',
                  backgroundColor: AppColors.categoryBeige,
                  tagColor: AppColors.categoryPurple,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choice your course',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildFilterButton('All', _selectedFilter == 'All'),
                    const SizedBox(width: 12),
                    _buildFilterButton('Poular', _selectedFilter == 'Popular'),
                    const SizedBox(width: 12),
                    _buildFilterButton('New', _selectedFilter == 'New'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: _filteredCourses.map((course) {
                return CourseListItem(
                  course: course,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.courseDetail,
                      arguments: course,
                    );
                  },
                );
              }).toList(),
            ),
          ),
          BottomNav(
            currentIndex: _currentNavIndex,
            onTap: (index) {
              setState(() {
                _currentNavIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
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
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label == 'Poular' ? 'Popular' : label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.buttonText : AppColors.textSecondary,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

