import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_resume/features/profile/data/db/user_profile_database_helper.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/user_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

part 'user_profile_data_state.dart';

class UserProfileDataCubit extends Cubit<UserProfileDataState> {
  final UserProfileDatabaseHelper dbHelper;
  UserProfileDataCubit({required this.dbHelper})
      : super(UserProfileDataInitial());

  void loadUserProfile({required UserProfile userProfile}) {
    print('Loading user profile...');
    emit(UserProfileDataLoaded(userProfile: userProfile));
    print('User profile loaded: $userProfile');
  }

  void updateUserProfile({required MyUser user}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedUserProfile =
          currentState.userProfile.copyWith(userdata: user);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addEducation({required EducationBackground education}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<EducationBackground>.from(currentState.userProfile.education)
            ..add(education);
      final updatedUserProfile =
          currentState.userProfile.copyWith(education: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateEducation(
      {required int index, required EducationBackground educationBackground}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<EducationBackground>.from(currentState.userProfile
              .copyWith(
                education: currentState.userProfile.education
                  ..[index] = educationBackground,
              )
              .education);
      final updatedUserProfile =
          currentState.userProfile.copyWith(education: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeEducation({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<EducationBackground>.from(currentState.userProfile.education)
            ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(education: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addWorkExperience({required WorkExperience workExperience}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<WorkExperience>.from(currentState.userProfile.workExperience)
            ..add(workExperience);
      final updatedUserProfile =
          currentState.userProfile.copyWith(workExperience: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateWorkExperience(
      {required int index, required WorkExperience workExperience}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<WorkExperience>.from(currentState.userProfile
          .copyWith(
            workExperience: currentState.userProfile.workExperience
              ..[index] = workExperience,
          )
          .workExperience);
      final updatedUserProfile =
          currentState.userProfile.copyWith(workExperience: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeWorkExperience({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<WorkExperience>.from(currentState.userProfile.workExperience)
            ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(workExperience: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addLanguage({required LanguageModel language}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<LanguageModel>.from(currentState.userProfile.languages)
            ..add(language);
      final updatedUserProfile =
          currentState.userProfile.copyWith(languages: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateLanguage(
      {required int index, required LanguageModel languageModel}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<LanguageModel>.from(currentState.userProfile
          .copyWith(
            languages: currentState.userProfile.languages
              ..[index] = languageModel,
          )
          .languages);
      final updatedUserProfile =
          currentState.userProfile.copyWith(languages: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeLanguage({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<LanguageModel>.from(currentState.userProfile.languages)
            ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(languages: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addCertificate({required CertificateModel certificate}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<CertificateModel>.from(currentState.userProfile.certificates)
            ..add(certificate);
      final updatedUserProfile =
          currentState.userProfile.copyWith(certificates: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateCertificate(
      {required int index, required CertificateModel certificateModel}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<CertificateModel>.from(currentState.userProfile
          .copyWith(
            certificates: currentState.userProfile.certificates
              ..[index] = certificateModel,
          )
          .certificates);
      final updatedUserProfile =
          currentState.userProfile.copyWith(certificates: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeCertificate({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<CertificateModel>.from(currentState.userProfile.certificates)
            ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(certificates: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addAward({required AwardModel award}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<AwardModel>.from(currentState.userProfile.awards)
        ..add(award);
      final updatedUserProfile =
          currentState.userProfile.copyWith(awards: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateAward({required int index, required AwardModel awardModel}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<AwardModel>.from(currentState.userProfile
          .copyWith(
            awards: currentState.userProfile.awards..[index] = awardModel,
          )
          .awards);
      final updatedUserProfile =
          currentState.userProfile.copyWith(awards: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeAward({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<AwardModel>.from(currentState.userProfile.awards)
        ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(awards: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addSkill({required String skill}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.skills)
        ..add(skill);
      final updatedUserProfile =
          currentState.userProfile.copyWith(skills: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateSkill({required int index, required String skill}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.skills)
        ..[index] = skill;
      final updatedUserProfile =
          currentState.userProfile.copyWith(skills: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeSkill({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.skills)
        ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(skills: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addPersonalProject({required String project}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<String>.from(currentState.userProfile.personalProjects)
            ..add(project);
      final updatedUserProfile =
          currentState.userProfile.copyWith(personalProjects: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updatePersonalProject({required int index, required String project}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<String>.from(currentState.userProfile.personalProjects)
            ..[index] = project;
      final updatedUserProfile =
          currentState.userProfile.copyWith(personalProjects: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removePersonalProject({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList =
          List<String>.from(currentState.userProfile.personalProjects)
            ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(personalProjects: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addInterest({required String interest}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.interests)
        ..add(interest);
      final updatedUserProfile =
          currentState.userProfile.copyWith(interests: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateInterest({required int index, required String interest}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.interests)
        ..[index] = interest;
      final updatedUserProfile =
          currentState.userProfile.copyWith(interests: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeInterest({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.interests)
        ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(interests: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void addReference({required String reference}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.references)
        ..add(reference);
      final updatedUserProfile =
          currentState.userProfile.copyWith(references: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void updateReference({required int index, required String reference}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.references)
        ..[index] = reference;
      final updatedUserProfile =
          currentState.userProfile.copyWith(references: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  void removeReference({required int index}) {
    if (state is UserProfileDataLoaded) {
      final currentState = state as UserProfileDataLoaded;
      final updatedList = List<String>.from(currentState.userProfile.references)
        ..removeAt(index);
      final updatedUserProfile =
          currentState.userProfile.copyWith(references: updatedList);
      emit(UserProfileDataLoaded(userProfile: updatedUserProfile));
    }
  }

  Future<void> saveUserProfileData({required UserProfile userProfile}) async {
    await dbHelper.insertUserProfile(userProfile: userProfile).then((value) {
      emit(UserProfileDataLoaded(userProfile: userProfile));
    }).catchError((e) {
      emit(UserProfileDataError(
          errorMessage: 'Failed to save user profile: $e'));
      log('Failed to save user profile: $e');
    });
  }
}
