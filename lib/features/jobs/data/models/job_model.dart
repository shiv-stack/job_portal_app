import '../../domain/entities/job.dart';

class JobModel extends Job {
  const JobModel({
    required super.id,
    required super.title,
    required super.company,
    required super.location,
    required super.description,
    required super.requirements,
    required super.salaryMin,
    required super.salaryMax,
    required super.postedAt,
    required super.type,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      requirements: List<String>.from(json['requirements'] ?? []),
      salaryMin: (json['salary_min'] as num).toDouble(),
      salaryMax: (json['salary_max'] as num).toDouble(),
      postedAt: DateTime.parse(json['created_at'] as String),
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'requirements': requirements,
      'salary_min': salaryMin,
      'salary_max': salaryMax,
      'created_at': postedAt.toIso8601String(),
      'type': type,
    };
  }
}
