import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/job_card.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(HomeStarted()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String displayName = 'Guest';
            if (state is AuthAuthenticated && state.user.email != null) {
              displayName = state.user.email!.split('@').first;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $displayName',
                  style: AppTextStyles.bodyMedium,
                ),
                Text(
                  'Find your perfect job',
                  style: AppTextStyles.titleLarge,
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.school_outlined), // Prep icon
            onPressed: () => context.push('/preparation'),
            tooltip: 'Preparation',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
        ],
        toolbarHeight: 80,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                label: '',
                hint: 'Search jobs, companies...',
                controller: TextEditingController(),
                prefixIcon: Icons.search,
              ),
            ),
          ),
           SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent Jobs',
                style: AppTextStyles.headlineMedium,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.status == HomeStatus.failure) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.errorMessage ?? 'Error fetching jobs')),
                );
              } else if (state.jobs.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No jobs found')),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final job = state.jobs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: JobCard(
                        job: job,
                        onTap: () {
                          // Navigate to details
                          context.push('/job/${job.id}', extra: job);
                        },
                      ),
                    );
                  },
                  childCount: state.jobs.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
