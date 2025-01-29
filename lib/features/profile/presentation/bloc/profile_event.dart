part of 'profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class SaveUserProfile extends UserProfileEvent {
  final UserProfile user;

  const SaveUserProfile({required this.user});

  @override
  List<Object> get props => [user];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateUserProfile extends UserProfileEvent{
  final UserProfile user;

  const UpdateUserProfile({required this.user});

  @override
  List<Object> get props => [user];
}

class DeleteUserProfile extends UserProfileEvent{
  const DeleteUserProfile();

  @override
  List<Object> get props => [];
}

