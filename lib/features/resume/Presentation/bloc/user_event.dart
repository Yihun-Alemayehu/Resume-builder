import 'package:equatable/equatable.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/user_data_model.dart';

abstract class TemplateDataEvent extends Equatable {
  const TemplateDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchTemplateData extends TemplateDataEvent {}

class SaveTemplateData extends TemplateDataEvent {
  final TemplateModel templateData;

  const SaveTemplateData({required this.templateData});

  @override
  List<Object?> get props => [templateData];
}
class UpdateTemplateData extends TemplateDataEvent {
  final int id;
  final TemplateModel templateData;

  const UpdateTemplateData({required this.id, required this.templateData});

  @override
  List<Object?> get props => [templateData];
}

class DeleteTemplateData extends TemplateDataEvent {
  final int id;

  const DeleteTemplateData({required this.id});

  @override
  List<Object?> get props => [id];
}

