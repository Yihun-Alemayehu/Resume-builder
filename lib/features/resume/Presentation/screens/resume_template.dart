import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/creative_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/hybrid_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/minimalist_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/modern_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/neat_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/screens/professional_template.dart';
import 'package:my_resume/features/resume/Presentation/templates/utils/templates_mapping.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/domain/generate_resume_repo.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_bloc.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_event.dart';

class ResumeTemplate extends StatefulWidget {
  final TemplateModel templateData;
  final bool isNewTemplate;
  final int index;
  const ResumeTemplate(
      {super.key,
      required this.templateData,
      required this.isNewTemplate,
      required this.index});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final TransformationController _transformationController =
      TransformationController();

  final Map<String, GlobalKey<State<StatefulWidget>>> _templateKeys = {
    'neat': GlobalKey<NeatTemplateState>(),
    'modern': GlobalKey<ModernTemplateState>(),
    'creative': GlobalKey<CreativeTemplateState>(),
    'minimalist': GlobalKey<MinimalistTemplateState>(),
    'hybrid': GlobalKey<HybridTemplateState>(),
    'professional': GlobalKey<ProfessionalTemplateState>(),
    // Add more templates as needed
  };

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String templateType = widget.templateData.templateName;

    // Retrieve the correct GlobalKey
    var selectedKey =
        _templateKeys[templateType] ?? GlobalKey<NeatTemplateState>();

    // Use a map to initialize the correct template screen
    Widget templateScreen =
        templatesMap[templateType]?.call(widget.templateData, selectedKey) ??
            NeatTemplate(templateData: widget.templateData, key: selectedKey);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to edit'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_open_sharp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final updatedData =
                  (selectedKey.currentState as dynamic)?.templateData;
              final updatedIcons =
                  (selectedKey.currentState as dynamic)?.icons;

              // Save the resume
              final pdfFile = await PdfApi.generateResume(
                  userData: updatedData!, icons: updatedIcons!);
              widget.isNewTemplate
                  ? context
                      .read<UserDataBloc>()
                      .add(SaveTemplateData(templateData: updatedData))
                  : context.read<UserDataBloc>().add(UpdateTemplateData(
                      id: widget.index, templateData: updatedData));
              PdfApi.openFile(pdfFile);
            },
          )
        ],
      ),
      body: SafeArea(
        child: InteractiveViewer(
          constrained: true,
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 3.0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: templateScreen,
          ),
        ),
      ),
    );
  }
}
