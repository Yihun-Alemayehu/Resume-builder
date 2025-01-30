import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';

class LanguagesTab extends StatefulWidget {
  const LanguagesTab({super.key});

  @override
  State<LanguagesTab> createState() => _LanguagesTabState();
}

class _LanguagesTabState extends State<LanguagesTab> {
  List<LanguageModel> _languages = [
    LanguageModel(
      language: 'language',
      proficiency: 'proficiency',
    )
  ];

  void _editLanguage(int index) {
    String selectedProficiency = 'Advanced';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Edit Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'Language',
                  function: (val) {
                    setState(() {
                      _languages[index] = _languages[index].copyWith(
                        language: val,
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  value: selectedProficiency,
                  items: <String>[
                    'Beginner',
                    'Intermediate',
                    'Advanced',
                    'Fluent'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProficiency = newValue!;
                      _languages[index] = _languages[index].copyWith(
                        proficiency: selectedProficiency,
                      );
                    });
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
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
      body: SingleChildScrollView(
        primary: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: List.generate(_languages.length, (index) {
              return SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _languages[index].language,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _languages[index].proficiency,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () => _editLanguage(index),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete Language at index
                                setState(() {
                                  _languages.removeAt(index);
                                });
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Language
          setState(() {
            _languages.add(
              LanguageModel(language: 'language', proficiency: 'proficiency'),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
