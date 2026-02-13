

import 'package:equatable/equatable.dart';

abstract class JobDetailsEvent extends Equatable {
  const JobDetailsEvent();

  @override
  List<Object> get props => [];
}

class ApplyForJob extends JobDetailsEvent {
  final String jobId;

  const ApplyForJob(this.jobId);

  @override
  List<Object> get props => [jobId];
}
