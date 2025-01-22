import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/bloc/user_event.dart';
import 'package:my_resume/bloc/user_state.dart';
import 'package:my_resume/db/db_helper.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final DatabaseHelper dbHelper;

  UserDataBloc({required this.dbHelper}) : super(UserDataInitial()) {
    on<FetchUserData>(_onFetchUserData);
    on<SaveUserData>(_onSaveUserData);
    on<DeleteUserData>(_onDeleteUserData);
  }

  // Handle FetchUserData event
  Future<void> _onFetchUserData(
      FetchUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    try {
      final userData = await dbHelper.fetchUserData();
      if (userData != null) {
        emit(UserDataLoaded(userData: userData));
      } else {
        emit(const UserDataError(message: 'You do not have any resume'));
      }
    } catch (e) {
      emit(UserDataError(message: 'Failed to load user data: $e'));
    }
  }

  // Handle SaveUserData event
  Future<void> _onSaveUserData(
      SaveUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    try {
      await dbHelper.upsertUserData(event.userData);
      emit(UserDataLoaded(userData: event.userData));
    } catch (e) {
      emit(UserDataError(message: 'Failed to save user data: $e'));
    }
  }

  // Handle SaveUserData event
  Future<void> _onDeleteUserData(
      DeleteUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    try {
      await dbHelper.deleteUserData(event.id);
      emit(UserDataDeleted());
    } catch (e) {
      emit(UserDataError(message: 'Failed to delete user data: $e'));
    }
  }
}
