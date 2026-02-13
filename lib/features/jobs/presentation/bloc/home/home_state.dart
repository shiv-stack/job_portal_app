import 'package:equatable/equatable.dart';
import '../../../domain/entities/job.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Job> jobs;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.jobs = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Job>? jobs,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      jobs: jobs ?? this.jobs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, jobs, errorMessage];
}
