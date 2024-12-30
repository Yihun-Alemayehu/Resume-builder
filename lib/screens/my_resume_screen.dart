import 'package:flutter/material.dart';

class MyResumeScreen extends StatefulWidget {
  const MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('My Resume Screen'),
      ),
    );
  }
}
