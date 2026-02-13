import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';

class MockJobRepository implements JobRepository {
  @override
  Future<List<Job>> getJobs() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate latency
    return [
      Job(
        id: '1',
        title: 'Senior Flutter Developer',
        company: 'Tech Corp',
        location: 'Remote',
        description: 'We are looking for an experienced Flutter developer to join our team. You will drive the development of our mobile applications.',
        requirements: const ['Dart', 'Flutter', 'State Management (BLoC)', 'Clean Architecture'],
        salaryMin: 80000,
        salaryMax: 120000,
        postedAt: DateTime.now(),
        type: 'Full-time',
      ),
      Job(
        id: '2',
        title: 'Backend Engineer',
        company: 'Data Systems',
        location: 'New York, NY',
        description: 'Join our backend team to build scalable APIs and manage high-traffic systems.',
        requirements: const ['Node.js', 'PostgreSQL', 'AWS', 'Docker'],
        salaryMin: 90000,
        salaryMax: 140000,
        postedAt: DateTime.now().subtract(const Duration(days: 2)),
        type: 'Full-time',
      ),
      Job(
        id: '3',
        title: 'Product Designer',
        company: 'Creative Studio',
        location: 'San Francisco, CA',
        description: 'Design beautiful user interfaces for our clients. We value creativity and attention to detail.',
        requirements: const ['Figma', 'UI/UX', 'Prototyping', 'User Research'],
        salaryMin: 70000,
        salaryMax: 110000,
        postedAt: DateTime.now().subtract(const Duration(days: 5)),
        type: 'Contract',
      ),
      Job(
        id: '4',
        title: 'Mobile App Developer',
        company: 'Startup Inc',
        location: 'Austin, TX',
        description: 'Looking for a passionate developer to build the next big thing.',
        requirements: const ['Flutter', 'Firebase', 'Git'],
        salaryMin: 60000,
        salaryMax: 90000,
        postedAt: DateTime.now().subtract(const Duration(hours: 4)),
        type: 'Full-time',
      ),
    ];
  }

  @override
  Future<Job> getJob(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jobs = await getJobs();
    return jobs.firstWhere((job) => job.id == id);
  }

  @override
  Future<void> applyForJob(String jobId, String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate success
  }
}
