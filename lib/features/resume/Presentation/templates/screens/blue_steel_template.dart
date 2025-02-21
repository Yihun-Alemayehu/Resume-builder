// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_resume/features/resume/data/model/templates_model.dart';

class BlueSteelTemplate extends StatefulWidget {
  TemplateModel templateData;
  BlueSteelTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<BlueSteelTemplate> createState() => BlueSteelTemplateState();
}

class BlueSteelTemplateState extends State<BlueSteelTemplate> {
  late TemplateModel templateData;

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