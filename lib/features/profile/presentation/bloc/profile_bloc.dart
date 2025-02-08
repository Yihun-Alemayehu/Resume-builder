import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_resume/features/profile/data/db/user_profile_database_helper.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileDatabaseHelper dbHelper;
  UserProfileBloc({required this.dbHelper}) : super(UserProfileInitial()) {
    on<SaveUserProfile>(_onSaveUserProfileHandler);
    on<FetchUserProfile>(_onFetchUserProfileHandler);
    on<UpdateUserProfile>(_onUpdateUserProfileHandler);
    on<DeleteUserProfile>(_onDeleteUserProfileHandler);
  }

  // Handle SaveUserProfile event
  Future<void> _onSaveUserProfileHandler(
      SaveUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      await dbHelper.insertUserProfile(userProfile: event.user);
      emit(UserProfileSaved());
    } catch (e) {
      emit(UserProfileError(errorMessage: 'Failed to save user profile: $e'));
    }
  }

  // Handle FetchUserProfile event
  Future<void> _onFetchUserProfileHandler(
      FetchUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      final UserProfile? userProfile = await dbHelper.fetchUserProfile();
      if (userProfile != null) {
        emit(UserProfileLoaded(user: [userProfile]));
      } else {
        emit(const UserProfileLoaded(user: []));
      }
    } catch (e) {
      emit(UserProfileError(errorMessage: 'Failed to load user profile: $e'));
    }
  }

  // Handle UpdateUserProfile event
  Future<void> _onUpdateUserProfileHandler(
      UpdateUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      await dbHelper.updateUserProfile(userProfile: event.user);
      emit(UserProfileUpdated(user: event.user));
    } catch (e) {
      emit(UserProfileError(errorMessage: 'Failed to update user profile: $e'));
    }
  }

  // Handle DeleteUserProfile event
  Future<void> _onDeleteUserProfileHandler(
      DeleteUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      await dbHelper.deleteUserProfile();
      emit(const UserProfileDeleted());
    } catch (e) {
      emit(UserProfileError(errorMessage: 'Failed to delete user profile: $e'));
    }
  }
}
