import 'package:equatable/equatable.dart';
import 'package:my_resume/data/model/user_data_model.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserData extends UserDataEvent {}

class SaveUserData extends UserDataEvent {
  final UserData userData;

  const SaveUserData({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class DeleteUserData extends UserDataEvent {
  final int id;

  const DeleteUserData({required this.id});

  @override
  List<Object?> get props => [id];
}

