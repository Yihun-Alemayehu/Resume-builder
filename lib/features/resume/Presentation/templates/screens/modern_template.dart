// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';

class ModernTemplate extends StatefulWidget {
  TemplateModel templateData;
  ModernTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<ModernTemplate> createState() => ModernTemplateState();
}

class ModernTemplateState extends State<ModernTemplate> {

  late TemplateModel templateData;

  List<File> icons = [
    File('assets/Icons/mail.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
  ];

  @override
  void initState() {
    templateData = widget.templateData;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Template Index: ${widget.templateData.templateIndex}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'User: ${widget.templateData.userData}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Education Background: ${widget.templateData.educationBackground.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Work Experience: ${widget.templateData.workExperience.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Languages: ${widget.templateData.languages.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Certificates: ${widget.templateData.certificates.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Awards: ${widget.templateData.awards.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Skills: ${widget.templateData.skills.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Personal Projects: ${widget.templateData.personalProjects.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Interests: ${widget.templateData.interests.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'References: ${widget.templateData.references.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
