// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_resume/features/resume/data/model/templates_model.dart';

class HybridTemplate extends StatefulWidget {
  TemplateModel templateData;
  HybridTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<HybridTemplate> createState() => HybridTemplateState();
}

class HybridTemplateState extends State<HybridTemplate> {
  late TemplateModel templateData;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}