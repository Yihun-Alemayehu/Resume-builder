part of 'profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSaved extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile user;

  const UserProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}


class UserProfileUpdated extends UserProfileState{
  final UserProfile user;

  const UserProfileUpdated({required this.user});

  @override
  List<Object> get props => [user];
}

class UserProfileDeleted extends UserProfileState{
  const UserProfileDeleted();

  @override
  List<Object> get props => [];
}

class UserProfileError extends UserProfileState{
  final String errorMessage;

  const UserProfileError({required this.errorMessage });

  @override
  List<Object> get props => [errorMessage];
}

