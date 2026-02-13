

import 'package:equatable/equatable.dart';

enum JobDetailsStatus { initial, applying, success, failure }

class JobDetailsState extends Equatable {
  final JobDetailsStatus status;
  final String? errorMessage;

  const JobDetailsState({
    this.status = JobDetailsStatus.initial,
    this.errorMessage,
  });

  JobDetailsState copyWith({
    JobDetailsStatus? status,
    String? errorMessage,
  }) {
    return JobDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
