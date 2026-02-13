import 'package:equatable/equatable.dart';

class PreparationContent extends Equatable {
  final String id;
  final String categoryId;
  final String title;
  final String body; // Could be markdown or rich text
  final String? solution;
  
  const PreparationContent({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.body,
    this.solution,
  });

  @override
  List<Object?> get props => [id, categoryId, title, body, solution];
}
