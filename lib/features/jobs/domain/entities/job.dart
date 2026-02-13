import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final List<String> requirements;
  final double salaryMin;
  final double salaryMax;
  final DateTime postedAt;
  final String type; // Full-time, Part-time, Contract

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.requirements,
    required this.salaryMin,
    required this.salaryMax,
    required this.postedAt,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        company,
        location,
        description,
        requirements,
        salaryMin,
        salaryMax,
        postedAt,
        type,
      ];
}
