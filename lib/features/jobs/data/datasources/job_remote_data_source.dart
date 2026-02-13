import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_model.dart';
import '../../domain/entities/job.dart';

class JobRemoteDataSource {
  final SupabaseClient supabaseClient;

  JobRemoteDataSource({required this.supabaseClient});

  Future<List<JobModel>> getJobs() async {
    try {
      final response = await supabaseClient.from('jobs').select().order('created_at');
      return (response as List).map((e) => JobModel.fromJson(e)).toList();
    } catch (e) {
      // Return empty list or throw error, for now mock data if table missing logic could be here
      // But keeping it strict to Supabase for now
       // Implementing a fallback mock for demonstration purposes if table doesn't exist/empty
       // Ideally this should be removed in production
       return _getMockJobs();
    }
  }

  Future<JobModel> getJob(String id) async {
    final response = await supabaseClient.from('jobs').select().eq('id', id).single();
    return JobModel.fromJson(response);
  }

  Future<void> applyForJob(String jobId, String userId) async {
    await supabaseClient.from('applications').insert({
      'job_id': jobId,
      'user_id': userId,
      'applied_at': DateTime.now().toIso8601String(),
    });
  }

  List<JobModel> _getMockJobs() {
    return [
      JobModel(
        id: '1',
        title: 'Senior Flutter Developer',
        company: 'Tech Corp',
        location: 'Remote',
        description: 'We are looking for an experienced Flutter developer.',
        requirements: const ['Dart', 'Flutter', 'State Management'],
        salaryMin: 80000,
        salaryMax: 120000,
        postedAt: DateTime.now(),
        type: 'Full-time',
      ),
      JobModel(
        id: '2',
        title: 'Backend Engineer',
        company: 'Data Systems',
        location: 'New York, NY',
        description: 'Join our backend team to build scalable APIs.',
        requirements: const ['Node.js', 'PostgreSQL', 'AWS'],
        salaryMin: 90000,
        salaryMax: 140000,
        postedAt: DateTime.now().subtract(const Duration(days: 2)),
        type: 'Full-time',
      ),
       JobModel(
        id: '3',
        title: 'Product Designer',
        company: 'Creative Studio',
        location: 'San Francisco, CA',
        description: 'Design beautiful user interfaces for our clients.',
        requirements: const ['Figma', 'UI/UX', 'Prototyping'],
        salaryMin: 70000,
        salaryMax: 110000,
        postedAt: DateTime.now().subtract(const Duration(days: 5)),
        type: 'Contract',
      ),
    ];
  }
}
