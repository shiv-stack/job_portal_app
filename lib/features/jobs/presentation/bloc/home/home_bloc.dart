import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/job_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final JobRepository _jobRepository;

  HomeBloc({required JobRepository jobRepository})
      : _jobRepository = jobRepository,
        super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final jobs = await _jobRepository.getJobs();
      emit(state.copyWith(status: HomeStatus.success, jobs: jobs));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()));
    }
  }
}
