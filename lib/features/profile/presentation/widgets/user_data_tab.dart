import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class UserDataTab extends StatefulWidget {
  const UserDataTab({super.key});

  @override
  State<UserDataTab> createState() => _UserDataTabState();
}

class _UserDataTabState extends State<UserDataTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
    setState(() {});
  }

  String profession = '';
  String fullName = '';
  String email = '';
  String website = '';
  String phoneNumber = '';
  String address = '';
  String bio = '';
  String github = '';
  String linkedIn = '';


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _image == null
                ? GestureDetector(
                    onTap: pickImage,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/copy.jpg'),
                    ),
                  )
                : GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(_image!),
                    ),
                  ),
            const SizedBox(height: 30),
            MyTextField(
              hintText: 'Profession title',
              function: (val) {
                setState(() {
                  profession = val;
                  print(profession);
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Full name',
              function: (val) {
                setState(() {
                  fullName = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Email address',
              function: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Website URL',
              function: (val) {
                setState(() {
                  website = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Github',
              function: (val) {
                setState(() {
                  github = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'LinkedIn',
              function: (val) {
                setState(() {
                  linkedIn = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Phone number',
              function: (val) {
                setState(() {
                  phoneNumber = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Address',
              function: (val) {
                setState(() {
                  address = val;
                });
              },
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Brief Description about yourself',
              function: (val) {
                setState(() {
                  bio = val;
                });
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 21, 135, 99),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Save the updated user data to the database here
                print('User data saved');
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

