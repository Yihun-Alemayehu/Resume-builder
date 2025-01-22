import 'package:equatable/equatable.dart';
import 'package:my_resume/data/model/user_data_model.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object?> get props => [];
}

// Initial state
class UserDataInitial extends UserDataState {}

// Loading state
class UserDataLoading extends UserDataState {}

// Loaded state
class UserDataLoaded extends UserDataState {
  final UserData userData;

  const UserDataLoaded({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class UserDataError extends UserDataState {
  final String message;

  const UserDataError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserDataDeleted extends UserDataState {}
