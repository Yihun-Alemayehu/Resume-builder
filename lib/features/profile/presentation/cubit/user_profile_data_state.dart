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
