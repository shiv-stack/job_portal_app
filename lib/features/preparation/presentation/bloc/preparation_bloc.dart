import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/preparation_content.dart';
import '../../domain/repositories/preparation_repository.dart';

import 'preparation_event.dart';
import 'preparation_state.dart';

class PreparationBloc extends Bloc<PreparationEvent, PreparationState> {
  final PreparationRepository _repository;

  PreparationBloc({required PreparationRepository repository})
      : _repository = repository,
        super(const PreparationState()) {
    on<PreparationContentRequested>(_onContentRequested);
  }

  Future<void> _onContentRequested(
    PreparationContentRequested event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: PreparationStatus.loading));
    try {
      final content = await _repository.getContentByCategory(event.categoryId);
      emit(state.copyWith(status: PreparationStatus.success, content: content));
    } catch (e) {
      emit(state.copyWith(
          status: PreparationStatus.failure, errorMessage: e.toString()));
    }
  }
}
