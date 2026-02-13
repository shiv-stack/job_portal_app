import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/job.dart';
import '../bloc/job_details/job_details_bloc.dart';
import '../bloc/job_details/job_details_event.dart';
import '../bloc/job_details/job_details_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<JobDetailsBloc>(),
      child: JobDetailsView(job: job),
    );
  }
}

class JobDetailsView extends StatelessWidget {
  final Job job;

  const JobDetailsView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocListener<JobDetailsBloc, JobDetailsState>(
        listener: (context, state) {
          if (state.status == JobDetailsStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Application Submitted Successfully!')),
            );
          } else if (state.status == JobDetailsStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Application Failed')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: 'job_logo_${job.id}',
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        job.company.substring(0, 1).toUpperCase(),
                        style: AppTextStyles.displayMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  job.title,
                  style: AppTextStyles.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${job.company} • ${job.location}',
                  style: AppTextStyles.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTag(job.type),
                  const SizedBox(width: 12),
                  _buildTag(timeago.format(job.postedAt)),
                ],
              ),
              const SizedBox(height: 32),
              Text('Job Description', style: AppTextStyles.titleLarge),
              const SizedBox(height: 8),
              Text(
                job.description,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text('Requirements', style: AppTextStyles.titleLarge),
              const SizedBox(height: 8),
              ...job.requirements.map((req) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            size: 20, color: AppColors.secondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(req, style: AppTextStyles.bodyMedium),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              Text('Salary', style: AppTextStyles.titleLarge),
              const SizedBox(height: 8),
              Text(
                '\$${(job.salaryMin / 1000).toStringAsFixed(0)}k - \$${(job.salaryMax / 1000).toStringAsFixed(0)}k /yr',
                style: AppTextStyles.headlineMedium.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 100), // Space for bottom button
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<JobDetailsBloc, JobDetailsState>(
          builder: (context, state) {
            return CustomButton(
              text: 'Apply Now',
              onPressed: () {
                context.read<JobDetailsBloc>().add(ApplyForJob(job.id));
              },
              isLoading: state.status == JobDetailsStatus.applying,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}
