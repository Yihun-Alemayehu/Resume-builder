part of 'user_profile_data_cubit.dart';

abstract class UserProfileDataState extends Equatable {
  const UserProfileDataState();

  @override
  List<Object> get props => [];
}

class UserProfileDataInitial extends UserProfileDataState {}

class UserProfileDataLoaded extends UserProfileDataState {
  final UserProfile userProfile;

  const UserProfileDataLoaded({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class UserProfileDataError extends UserProfileDataState {
  final String errorMessage;
  const UserProfileDataError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
