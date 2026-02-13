

import 'package:equatable/equatable.dart';

abstract class PreparationEvent extends Equatable {
  const PreparationEvent();

  @override
  List<Object> get props => [];
}

class PreparationContentRequested extends PreparationEvent {
  final String categoryId;

  const PreparationContentRequested(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
