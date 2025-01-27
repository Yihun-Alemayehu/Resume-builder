import 'package:equatable/equatable.dart';
import 'package:my_resume/data/model/user_data_model.dart';

abstract class TemplateDataEvent extends Equatable {
  const TemplateDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchTemplateData extends TemplateDataEvent {}

class SaveTemplateData extends TemplateDataEvent {
  final UserData userData;

  const SaveTemplateData({required this.userData});

  @override
  List<Object?> get props => [userData];
}
class UpdateTemplateData extends TemplateDataEvent {
  final int id;
  final UserData userData;

  const UpdateTemplateData({required this.id, required this.userData});

  @override
  List<Object?> get props => [userData];
}

class DeleteTemplateData extends TemplateDataEvent {
  final int id;

  const DeleteTemplateData({required this.id});

  @override
  List<Object?> get props => [id];
}

