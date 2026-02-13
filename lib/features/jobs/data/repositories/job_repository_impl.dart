import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;

  JobRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Job>> getJobs() async {
    return await remoteDataSource.getJobs();
  }

  @override
  Future<Job> getJob(String id) async {
    return await remoteDataSource.getJob(id);
  }

  @override
  Future<void> applyForJob(String jobId, String userId) async {
    await remoteDataSource.applyForJob(jobId, userId);
  }
}
