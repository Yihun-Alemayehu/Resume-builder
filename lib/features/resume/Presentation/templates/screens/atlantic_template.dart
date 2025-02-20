// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:my_resume/features/resume/data/model/templates_model.dart';

class AtlanticTemplate extends StatefulWidget {
  TemplateModel templateData;
  AtlanticTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<AtlanticTemplate> createState() => AtlanticTemplateState();
}

class AtlanticTemplateState extends State<AtlanticTemplate> {
  late TemplateModel templateData;

  List<File> icons = [
    File('assets/Icons/mail.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
    File('assets/Icons/briefcase.png'),
    File('assets/Icons/education.png'),
    File('assets/Icons/skill.png'),
    File('assets/Icons/project.png'),
    File('assets/Icons/language.png'),
    File('assets/Icons/hobby.png'),
  ];

  @override
  void initState() {
    super.initState();
    templateData = widget.templateData;
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}