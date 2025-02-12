import 'package:flutter/material.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/creative_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/modern_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/neat_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/creative_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/modern_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/neat_template.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';

final Map<String, TemplateModel> templatesDataMap = {
  'neat': neatTemplateData,
  'creative': creativeTemplateData,
 'modern': modernTemplateData,
};

// Function to return the widget associated with a given template type
TemplateModel getTemplateData({required int templateIndex}) {
  switch (templateIndex) {
    case 0:
      return neatTemplateData;
    case 1:
      return creativeTemplateData;
    case 2:
      return modernTemplateData;
    default:
      throw 'Invalid template index';
  }
}
// Map to associate template types with their corresponding widgets
final Map<String, Widget Function(TemplateModel, GlobalKey)> templatesMap = {
  'neat': (TemplateModel templateData, GlobalKey key) => NeatTemplate(
    templateData: templateData, 
    key: key,
  ),
  'creative': (TemplateModel templateData, GlobalKey key) => CreativeTemplate(
    templateData: templateData, 
    key: key,
  ),
  'modern': (TemplateModel templateData, GlobalKey key) => ModernTemplate(
    templateData: templateData, 
    key: key,
  ),
  // Add more templates here
};
