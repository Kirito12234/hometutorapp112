import '../../domain/entities/course.dart';
import '../../../dashboard/domain/entities/lesson.dart';

class DummyCourses {
  static List<Course> getCourses() {
    return [
      Course(
        id: '1',
        title: 'ProductDesign v1.0',
        instructor: 'sagar shrestha',
        price: 19000,
        durationHours: 6,
        lessonCount: 24,
        category: 'Design',
        description: 'So that you can clearly understand where all this mistake comes from, the mistake that causes blame and pain, and so that you can clearly understand where all this mistake comes from.',
        isBestseller: true,
        isPopular: true,
        lessons: [
          Lesson(
            id: '1-1',
            title: 'Welcome to the Course',
            durationMinutes: 6,
            isCompleted: true,
            order: 1,
          ),
          Lesson(
            id: '1-2',
            title: 'Process overview',
            durationMinutes: 6,
            order: 2,
          ),
          Lesson(
            id: '1-3',
            title: 'Discovery',
            durationMinutes: 6,
            isLocked: true,
            order: 3,
          ),
          Lesson(
            id: '1-4',
            title: 'User Research',
            durationMinutes: 8,
            isLocked: true,
            order: 4,
          ),
          Lesson(
            id: '1-5',
            title: 'Wireframing',
            durationMinutes: 10,
            isLocked: true,
            order: 5,
          ),
        ],
      ),
      Course(
        id: '2',
        title: 'Java Development',
        instructor: 'Albert Maharjan',
        price: 50000,
        durationHours: 16,
        lessonCount: 32,
        category: 'Coding',
        description: 'Learn Java programming from scratch with hands-on projects and real-world examples.',
        isPopular: true,
        lessons: [
          Lesson(
            id: '2-1',
            title: 'Introduction to Java',
            durationMinutes: 10,
            order: 1,
          ),
          Lesson(
            id: '2-2',
            title: 'Variables and Data Types',
            durationMinutes: 12,
            order: 2,
          ),
        ],
      ),
      Course(
        id: '3',
        title: 'Visual Design',
        instructor: 'Bishikha Satgaiya',
        price: 20000,
        durationHours: 14,
        lessonCount: 20,
        category: 'Design',
        description: 'Master the fundamentals of visual design and create stunning graphics.',
        isNew: true,
        lessons: [
          Lesson(
            id: '3-1',
            title: 'Design Principles',
            durationMinutes: 8,
            order: 1,
          ),
        ],
      ),
      Course(
        id: '4',
        title: 'Product Design',
        instructor: 'santosh shrestha',
        price: 19000,
        durationHours: 16,
        lessonCount: 24,
        category: 'Design',
        description: 'Complete product design course covering all aspects of design thinking.',
        lessons: [
          Lesson(
            id: '4-1',
            title: 'Introduction',
            durationMinutes: 5,
            order: 1,
          ),
        ],
      ),
      Course(
        id: '5',
        title: 'Product Design',
        instructor: 'Sagar Sharestha',
        price: 25000,
        durationHours: 14,
        lessonCount: 18,
        category: 'Design',
        description: 'Advanced product design techniques and methodologies.',
        lessons: [
          Lesson(
            id: '5-1',
            title: 'Getting Started',
            durationMinutes: 7,
            order: 1,
          ),
        ],
      ),
      Course(
        id: '6',
        title: 'Product Design',
        instructor: 'Andersh shahi',
        price: 30000,
        durationHours: 16,
        lessonCount: 22,
        category: 'Design',
        description: 'Master product design with industry experts.',
        lessons: [
          Lesson(
            id: '6-1',
            title: 'Course Overview',
            durationMinutes: 6,
            order: 1,
          ),
        ],
      ),
    ];
  }

  static List<Course> filterCourses({
    List<String>? categories,
    String? durationRange,
    double? minPrice,
    double? maxPrice,
  }) {
    var courses = getCourses();
    
    if (categories != null && categories.isNotEmpty) {
      courses = courses.where((c) => categories.contains(c.category)).toList();
    }
    
    if (durationRange != null) {
      final ranges = durationRange.split('-');
      if (ranges.length == 2) {
        final min = int.tryParse(ranges[0].trim());
        final max = int.tryParse(ranges[1].split(' ')[0].trim());
        if (min != null && max != null) {
          courses = courses.where((c) => c.durationHours >= min && c.durationHours <= max).toList();
        }
      }
    }
    
    if (minPrice != null) {
      courses = courses.where((c) => c.price >= minPrice).toList();
    }
    
    if (maxPrice != null) {
      courses = courses.where((c) => c.price <= maxPrice).toList();
    }
    
    return courses;
  }
}

