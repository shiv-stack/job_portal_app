import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/preparation_category.dart';

class PreparationDashboard extends StatelessWidget {
  const PreparationDashboard({super.key});

  static const List<PreparationCategory> categories = [
    PreparationCategory(
      id: '1',
      title: 'Aptitude',
      description: 'Master quantitative and logical reasong',
      icon: Icons.calculate_outlined,
      color: Colors.orange,
      route: '/preparation/aptitude',
    ),
    PreparationCategory(
      id: '2',
      title: 'DSA',
      description: 'Data Structures and Algorithms',
      icon: Icons.code,
      color: Colors.blue,
      route: '/preparation/dsa',
    ),
    PreparationCategory(
      id: '3',
      title: 'Technical',
      description: 'Core CS concepts and language specifics',
      icon: Icons.computer,
      color: Colors.purple,
      route: '/preparation/technical',
    ),
    PreparationCategory(
      id: '4',
      title: 'HR Interview',
      description: 'Behavioral questions and soft skills',
      icon: Icons.people_outline,
      color: Colors.green,
      route: '/preparation/hr',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Interview Preparation'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(context, category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, PreparationCategory category) {
    return GestureDetector(
      onTap: () {
        context.push(category.route);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(category.icon, color: category.color, size: 28),
            ),
            const Spacer(),
            Text(
              category.title,
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              category.description,
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
