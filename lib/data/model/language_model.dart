// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LanguageModel {
  LanguageModel({
    required this.language,
    required this.proficiency,
  });
  
  final String language;
  final String proficiency;

  LanguageModel copyWith({
    String? language,
    String? proficiency,
  }) {
    return LanguageModel(
      language: language ?? this.language,
      proficiency: proficiency ?? this.proficiency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'proficiency': proficiency,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      language: map['language'] as String,
      proficiency: map['proficiency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) => LanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LanguageModel(language: $language, proficiency: $proficiency)';

}
