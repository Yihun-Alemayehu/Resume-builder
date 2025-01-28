import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_event.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_state.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_data_model.dart';
import 'package:my_resume/features/resume/data/db/db_helper.dart';

class UserDataBloc extends Bloc<TemplateDataEvent, TemplateDataState> {
  final DatabaseHelper dbHelper;

  UserDataBloc({required this.dbHelper}) : super(TemplateDataInitial()) {
    on<SaveTemplateData>(_onSaveTemplate);
    on<FetchTemplateData>(_onFetchTemplates);
    on<UpdateTemplateData>(_onUpdateTemplate);
    on<DeleteTemplateData>(_onDeleteTemplate);
  }

  // Handle SaveTemplateData event
  Future<void> _onSaveTemplate(
      SaveTemplateData event, Emitter<TemplateDataState> emit) async {
    emit(TemplateDataLoading());
    try {
      await dbHelper.insertTemplate(template: event.templateData);
      emit(TemplateDataSaved());
    } catch (e) {
      emit(TemplateDataError(message: 'Failed to save template data: $e'));
    }
  }

  // Handle FetchTemplateData event
  Future<void> _onFetchTemplates(
      FetchTemplateData event, Emitter<TemplateDataState> emit) async {
    emit(TemplateDataLoading());
    try {
      final List<TemplateModel>? userData = await dbHelper.fetchTemplates();
      if (userData != null) {
        emit(TemplateDataLoaded(userData: userData));
      } else {
        emit(const TemplateDataError(message: 'You do not have any resume'));
      }
    } catch (e) {
      emit(TemplateDataError(message: 'Failed to load user data: $e'));
    }
  }

  // Handle UpdateTemplateData event
  Future<void> _onUpdateTemplate(
      UpdateTemplateData event, Emitter<TemplateDataState> emit) async {
    emit(TemplateDataLoading());
    try {
      await dbHelper.updateTemplate(id: event.id, template: event.templateData);
      emit(TemplateDataSaved());
    } catch (e) {
      emit(TemplateDataError(message: 'Failed to update template data: $e'));
    }
  }

  // Handle SaveUserData event
  Future<void> _onDeleteTemplate(
      DeleteTemplateData event, Emitter<TemplateDataState> emit) async {
    emit(TemplateDataLoading());
    try {
      await dbHelper.deleteTemplate(id: event.id);
      emit(TemplateDataDeleted());
    } catch (e) {
      emit(TemplateDataError(message: 'Failed to delete user data: $e'));
    }
  }
}
