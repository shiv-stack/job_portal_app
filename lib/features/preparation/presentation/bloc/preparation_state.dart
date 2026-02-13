import 'package:equatable/equatable.dart';
import '../../domain/entities/preparation_content.dart';

enum PreparationStatus { initial, loading, success, failure }

class PreparationState extends Equatable {
  final PreparationStatus status;
  final List<PreparationContent> content;
  final String? errorMessage;

  const PreparationState({
    this.status = PreparationStatus.initial,
    this.content = const [],
    this.errorMessage,
  });

  PreparationState copyWith({
    PreparationStatus? status,
    List<PreparationContent>? content,
    String? errorMessage,
  }) {
    return PreparationState(
      status: status ?? this.status,
      content: content ?? this.content,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, content, errorMessage];
}
