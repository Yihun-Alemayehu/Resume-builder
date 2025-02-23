import 'package:flutter/material.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/atlantic_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/blue_steel_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/creative_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/desert_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/hybrid_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/minimalist_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/modern_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/neat_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/professional_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/data/sleek_template_data.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/atlantic_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/blue_steel_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/creative_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/desert_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/hybrid_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/minimalist_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/modern_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/neat_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/professional_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/sleek_template.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';

final Map<String, TemplateModel> templatesDataMap = {
  'neat': neatTemplateData,
  'creative': creativeTemplateData,
  'modern': modernTemplateData,
  'minimalist': minimalistTemplateData,
  'hybrid': hybridTemplateData,
  'professional': professionalTemplateData,
  'atlantic': atlanticTemplateData,
  'desert': desertTemplateData,
  'blue_steel': blueSteelTemplateData,
  'sleek': sleekTemplateData,
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
    case 3:
      return minimalistTemplateData;
    case 4:
      return hybridTemplateData;
    case 5:
      return professionalTemplateData;
    case 6:
      return atlanticTemplateData;
    case 7:
      return desertTemplateData;
    case 8:
      return blueSteelTemplateData;
    case 9:
      return sleekTemplateData;
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
  'minimalist': (TemplateModel templateData, GlobalKey key) =>
      MinimalistTemplate(
        templateData: templateData,
        key: key,
      ),
  'hybrid': (TemplateModel templateData, GlobalKey key) => HybridTemplate(
        templateData: templateData,
        key: key,
      ),
  'professional': (TemplateModel templateData, GlobalKey key) =>
      ProfessionalTemplate(
        templateData: templateData,
        key: key,
      ),
  'atlantic': (TemplateModel templateData, GlobalKey key) => AtlanticTemplate(
        templateData: templateData,
        key: key,
      ),
  'desert': (TemplateModel templateData, GlobalKey key) => DesertTemplate(
        templateData: templateData,
        key: key,
      ),
  'blue_steel': (TemplateModel templateData, GlobalKey key) => BlueSteelTemplate(
        templateData: templateData,
        key: key,
      ),
  'sleek': (TemplateModel templateData, GlobalKey key) => SleekTemplate(
        templateData: templateData,
        key: key,
      ),
  // Add more templates here
};

// Blue Steel Minimalist Resume for Professionals
// Classic One-Column Resume for Professionals
// Classic and Simple Resume with Blue Accents
// Professional Multi-Column Resume Template
// Sunset Multi-Column Resume for Professionals
// Minimalistic Grey Simple Resume for Professionals
// Free Classic Multi-Column Serif Resume Template
// Minimalist Classic Resume for Professionals
// Desert Rock Two-Column Resume for Professionals