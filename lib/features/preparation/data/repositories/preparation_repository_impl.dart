import '../../domain/entities/preparation_content.dart';
import '../../domain/repositories/preparation_repository.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  @override
  Future<List<PreparationContent>> getContentByCategory(String categoryId) async {
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    switch (categoryId) {
      case '1': // Aptitude
        return _aptitudeContent;
      case '2': // DSA
        return _dsaContent;
      case '3': // Technical
        return _technicalContent;
      case '4': // HR
        return _hrContent;
      default:
        return [];
    }
  }

  final List<PreparationContent> _aptitudeContent = [
    const PreparationContent(
      id: 'a1',
      categoryId: '1',
      title: 'Time and Work',
      body: 'If A can do a work in 10 days and B in 15 days, how long will they take via working together?',
      solution: '1/10 + 1/15 = 5/30 = 1/6. So 6 days.',
    ),
    const PreparationContent(
      id: 'a2',
      categoryId: '1',
      title: 'Probability',
      body: 'What is the probability of getting a sum of 7 when rolling two dice?',
      solution: 'Outcomes with sum 7: (1,6), (2,5), (3,4), (4,3), (5,2), (6,1). Total 6. 6/36 = 1/6.',
    ),
  ];

  final List<PreparationContent> _dsaContent = [
    const PreparationContent(
      id: 'd1',
      categoryId: '2',
      title: 'Array Reversal',
      body: 'Write a function to reverse an array in-place.',
      solution: 'Use two pointers, one at start and one at end, swap and move towards center.',
    ),
    const PreparationContent(
      id: 'd2',
      categoryId: '2',
      title: 'Binary Search',
      body: 'Explain Binary Search algorithm.',
      solution: 'Search a sorted array by repeatedly dividing the search interval in half.',
    ),
  ];
   final List<PreparationContent> _technicalContent = [
    const PreparationContent(
      id: 't1',
      categoryId: '3',
      title: 'Flutter Lifecycle',
      body: 'Explain the lifecycle of a Stateful Widget.',
      solution: 'createState -> initState -> didChangeDependencies -> build -> didUpdateWidget -> setState -> deactivate -> dispose',
    ),
  ];
   final List<PreparationContent> _hrContent = [
    const PreparationContent(
      id: 'h1',
      categoryId: '4',
      title: 'Tell me about yourself',
      body: 'Standard introduction question.',
      solution: 'Start with current role, key achievements, past relevant experience, and why you are here.',
    ),
  ];
}
