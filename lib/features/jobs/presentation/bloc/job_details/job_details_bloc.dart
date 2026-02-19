import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/job_repository.dart';

import 'job_details_event.dart';
import 'job_details_state.dart';

class JobDetailsBloc extends Bloc<JobDetailsEvent, JobDetailsState> {
  final JobRepository _jobRepository;

  JobDetailsBloc({required JobRepository jobRepository})
      : _jobRepository = jobRepository,
        super(const JobDetailsState()) {
    on<ApplyForJob>(_onApplyForJob);
  }

  Future<void> _onApplyForJob(
    ApplyForJob event,
    Emitter<JobDetailsState> emit,
  ) async {
    emit(state.copyWith(status: JobDetailsStatus.applying));
    try {
      // In a real app, we would get the userId from AuthRepository
      // For now, we simulate a user ID or pass it
      await _jobRepository.applyForJob(event.jobId, "user_123"); 
      emit(state.copyWith(status: JobDetailsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: JobDetailsStatus.failure, errorMessage: e.toString()));
    }
  }
}
