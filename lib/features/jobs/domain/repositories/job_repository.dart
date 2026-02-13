import '../entities/job.dart';

abstract class JobRepository {
  Future<List<Job>> getJobs();
  Future<Job> getJob(String id);
  Future<void> applyForJob(String jobId, String userId);
}
