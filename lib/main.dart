import 'package:flutter/material.dart';
import 'package:my_resume/screens/pdf_screen.dart';
import 'package:my_resume/screens/resume_template.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResumeTemplate(),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('EDUCATION'),
            _buildEducation(),
            const SizedBox(height: 20),
            _buildSectionTitle('WORK EXPERIENCE'),
            _buildWorkExperience(),
            const SizedBox(height: 20),
            _buildSectionTitle('SKILLS'),
            _buildSkills(),
            const SizedBox(height: 20),
            _buildSectionTitle('PERSONAL PROJECTS'),
            _buildProjects(),
            const SizedBox(height: 20),
            _buildSectionTitle('LANGUAGES'),
            _buildLanguages(),
            const SizedBox(height: 20),
            _buildSectionTitle('INTERESTS'),
            _buildInterests(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yihun Alemayehu',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          'Flutter Developer',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 10),
        Text(
          'Enthusiastic and innovative Junior Flutter Developer and Graphics Designer ready to bring a unique blend of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic design tools, I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for user-centric design and a commitment to staying at the forefront of emerging technologies, I am eager to contribute my skills and learn from experienced professionals in a collaborative environment.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 10),
        Text(
          'Contact: yankure01@gmail.com | 982394038 | Addis Ababa, Ethiopia',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          'Portfolio: yihun-alemayehu.netlify.app | LinkedIn: linkedin.com/in/yihun-alemayehu-99189326b | GitHub: github.com/Yihun-Alemayehu',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildEducation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Software Engineering',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
            'Addis Ababa Science and Technology University (05/2022 - Present)'),
        Text(
          'Relevant Courses: Internet programming, Mobile App Development, Object-Oriented Programming, Data Structures, Database, Assembly Language',
        ),
        SizedBox(height: 10),
        Text(
          'Mobile App Development',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('GDSC (10/2023 - 03/2024)'),
        Text('Technologies: Dart, Flutter'),
      ],
    );
  }

  Widget _buildWorkExperience() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Intern Flutter Developer, Hex Labs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('10/2023 - 01/2024 (Remote)'),
        Text(
            '- Optimized widget rendering in a critical feature, reducing load times by 20%.'),
        Text(
            '- Transitioned payment gateway from Telebirr to Chapa, enhancing reliability.'),
        SizedBox(height: 10),
        Text(
          'Graphics Designer, Tsinat Studio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('11/2021 - Present (Remote)'),
        SizedBox(height: 10),
        Text(
          'Graphics Designer & Video Editor, Yishal Digital Studio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('06/2019 - Present (Seasonal)'),
      ],
    );
  }

  Widget _buildSkills() {
    return const Wrap(
      spacing: 10,
      children: [
        Chip(label: Text('Flutter')),
        Chip(label: Text('Dart')),
        Chip(label: Text('Firebase')),
        Chip(label: Text('Figma')),
        Chip(label: Text('State Management')),
        Chip(label: Text('Graphics Design')),
        Chip(label: Text('Leadership')),
        Chip(label: Text('Communication')),
      ],
    );
  }

  Widget _buildProjects() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GraceLink Mobile App'),
        Text('AddisCart Mobile App'),
        Text('Guadaye Mobile App'),
        Text('Nedemy Mobile App'),
        Text('Yize-Chat Mobile App'),
      ],
    );
  }

  Widget _buildLanguages() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('English: Full Professional Proficiency'),
        Text('Amharic: Full Professional Proficiency'),
      ],
    );
  }

  Widget _buildInterests() {
    return const Text(
        'Space Science, Programming, Photography, Reading, Artificial Intelligence');
  }
}
