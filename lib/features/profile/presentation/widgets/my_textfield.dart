import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Function(String val) function;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
      style: const TextStyle(fontSize: 14),
      onChanged: function,
    );
  }
}