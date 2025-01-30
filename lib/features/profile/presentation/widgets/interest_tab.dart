import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class InterestTab extends StatefulWidget {
  const InterestTab({super.key});

  @override
  State<InterestTab> createState() => _InterestTabState();
}

class _InterestTabState extends State<InterestTab> {
  List<String> _interests = [
    'Football',
    'Piano',
    'Reading',
    'Hiking',
    'Movie',
    'Chess'
  ];

  final TextEditingController _controller = TextEditingController();

  void _addInterest() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Add Interest'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'interest',
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
                  _interests.add(_controller.text);
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
          _interests.length,
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
                      _interests[index],
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
                          _interests.removeAt(index);
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
        onPressed: _addInterest,
        child: const Icon(Icons.add),
      ),
    );
  }
}
