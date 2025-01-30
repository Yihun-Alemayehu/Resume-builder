import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class SkillTab extends StatefulWidget {
  const SkillTab({super.key});

  @override
  State<SkillTab> createState() => _SkillTabState();
}

class _SkillTabState extends State<SkillTab> {
  List<String> _skills = [
    'Java',
    'Python',
    'JavaScript',
    'Dart',
    'Kotlin',
    'Swift'
  ];

  final TextEditingController _controller = TextEditingController();

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Add Skill'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'Skill Name',
                  function: (val) {
                    setState(() {
                      _controller.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _skills.add(_controller.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        spacing: 4,
        children: List.generate(
          _skills.length,
          (index) {
            return IntrinsicWidth(
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                margin: const EdgeInsets.only(right: 4, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 73, 150, 159),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _skills[index],
                      style: const TextStyle(
                          // fontSize: 16,
                          ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _skills.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSkill,
        child: const Icon(Icons.add),
      ),
    );
  }
}
