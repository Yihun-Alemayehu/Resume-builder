import 'package:equatable/equatable.dart';
import 'package:my_resume/features/resume/data/model/user_data_model.dart';

abstract class TemplateDataState extends Equatable {
  const TemplateDataState();

  @override
  List<Object?> get props => [];
}

// Initial state
class TemplateDataInitial extends TemplateDataState {}

// Loading state
class TemplateDataLoading extends TemplateDataState {}

class TemplateDataSaved extends TemplateDataState {}

// Loaded state
class TemplateDataLoaded extends TemplateDataState {
  final List<UserData> userData;

  const TemplateDataLoaded({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class TemplateDataError extends TemplateDataState {
  final String message;

  const TemplateDataError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TemplateDataDeleted extends TemplateDataState {}
