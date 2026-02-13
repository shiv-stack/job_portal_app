import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/jobs/presentation/pages/home_screen.dart';
import '../../features/jobs/presentation/pages/job_details_screen.dart';
import '../../features/jobs/domain/entities/job.dart';
import '../../features/preparation/presentation/pages/preparation_dashboard.dart';
import '../../features/preparation/presentation/pages/content_screen.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

// Placeholder Home Screen until we create the real one

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/job/:id',
      builder: (context, state) {
        final job = state.extra as Job;
        return JobDetailsScreen(job: job);
      },
    ),
    GoRoute(
      path: '/preparation',
      builder: (context, state) => const PreparationDashboard(),
    ),
    GoRoute(
      path: '/preparation/:type',
      builder: (context, state) {
        final type = state.pathParameters['type']!;
        String title = 'Preparation';
        String id = '1';
        
        switch (type) {
          case 'aptitude':
            title = 'Aptitude';
            id = '1';
            break;
          case 'dsa':
            title = 'DSA';
            id = '2';
            break;
          case 'technical':
            title = 'Technical';
            id = '3';
            break;
          case 'hr':
            title = 'HR Interview';
            id = '4';
            break;
        }
        
        return PreparationContentScreen(categoryId: id, title: title);
      },
    ),
  ],
);
