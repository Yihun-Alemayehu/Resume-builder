// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectModel {
  final String name;
  final String description;
  ProjectModel({
    required this.name,
    required this.description,
  });

  ProjectModel copyWith({
    String? name,
    String? description,
  }) {
    return ProjectModel(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProjectModel(name: $name, description: $description)';

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
