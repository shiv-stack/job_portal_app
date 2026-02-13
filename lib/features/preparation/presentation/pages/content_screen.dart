import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/preparation_category.dart';
import '../bloc/preparation_bloc.dart';
import '../bloc/preparation_event.dart';
import '../bloc/preparation_state.dart';

class PreparationContentScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const PreparationContentScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PreparationBloc>()
        ..add(PreparationContentRequested(categoryId)),
      child: PreparationContentView(title: title),
    );
  }
}

class PreparationContentView extends StatelessWidget {
  final String title;

  const PreparationContentView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<PreparationBloc, PreparationState>(
        builder: (context, state) {
          if (state.status == PreparationStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PreparationStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error loading content'));
          } else if (state.content.isEmpty) {
            return const Center(child: Text('No content available for this section'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.content.length,
            itemBuilder: (context, index) {
              final item = state.content[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    item.title,
                    style: AppTextStyles.titleMedium,
                  ),
                  childrenPadding: const EdgeInsets.all(16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.body,
                      style: AppTextStyles.bodyMedium,
                    ),
                    if (item.solution != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Answer / Solution:',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.solution!,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
