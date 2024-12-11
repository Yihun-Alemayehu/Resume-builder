import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:my_resume/widgets/container_decoration.dart';

class DatePickFormField extends StatefulWidget {
  final Function(String, String) editableField;
  final String fieldName;

  const DatePickFormField({
    super.key,
    required this.editableField,
    required this.fieldName,
  });

  @override
  State<DatePickFormField> createState() => _DatePickFormFieldState();
}

class _DatePickFormFieldState extends State<DatePickFormField> {
  final TextEditingController _startTextController = TextEditingController();
  final TextEditingController _endTextController = TextEditingController();
  bool isCurrentlyWorking = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.fieldName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                const Text(
                  'X',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FormBuilder(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fieldName,
                    style: const TextStyle(fontSize: 17),
                  ),
                  ContainerDecoration(
                    child: FormBuilderDateTimePicker(
                      inputType: InputType.date,
                      format: DateFormat('MM/yyyy'),
                      name: 'Start Date',
                      controller: _startTextController,
                      decoration: InputDecoration(
                        hintText: 'Insert Start Date',
                        hintStyle:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          size: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.fieldName,
                    style: const TextStyle(fontSize: 17),
                  ),
                  ContainerDecoration(
                    child: FormBuilderDateTimePicker(
                      enabled: !isCurrentlyWorking,
                      inputType: InputType.date,
                      format: DateFormat('MM/yyyy'),
                      name: 'End Date',
                      controller: _endTextController,
                      decoration: InputDecoration(
                        hintText: 'Insert End Date',
                        hintStyle:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          size: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  FormBuilderCheckbox(
                      initialValue: isCurrentlyWorking,
                      onChanged: (value) {
                        setState(() {
                          isCurrentlyWorking = value!;
                        });
                      },
                      name: 'final date',
                      title: const Text('Currently working ?')),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        widget.editableField(_startTextController.text, !isCurrentlyWorking ? _endTextController.text : 'Present');
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
