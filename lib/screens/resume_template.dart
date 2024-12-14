import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/data/model/user_model.dart';
import 'package:my_resume/widgets/date_pick_form_field.dart';
import 'package:my_resume/widgets/edit_field.dart';
import 'package:my_resume/widgets/phone_number_field.dart';

class ResumeTemplate extends StatefulWidget {
  const ResumeTemplate({super.key});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final TransformationController _transformationController =
      TransformationController(); // Manages zoom
  final FocusNode _nameFocusNode = FocusNode(); // Focus for name field
  final FocusNode _professionFocusNode =
      FocusNode(); // Focus for profession field

  final GlobalKey nameFieldKey = GlobalKey(); // Key for the name field

  void _zoomToField(GlobalKey fieldKey) {
    // Get the field's position
    final RenderBox? renderBox =
        fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position =
          renderBox.localToGlobal(Offset.zero); // Position on screen
      final size = renderBox.size; // Size of the field
      print('Field position: $position, Size: $size');

      // Adjust zoom to focus on the field
      setState(() {
        _transformationController.value = Matrix4.identity()
          ..scale(2.0) // Zoom scale
          ..translate(-position.dx + size.width / 2, -size.height);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Add listeners for zoom behavior
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        _zoomToField(nameFieldKey); // Adjust for name field position
      }
    });

    _professionFocusNode.addListener(() {
      if (_professionFocusNode.hasFocus) {
        _zoomToField(nameFieldKey); // Adjust for profession field position
      }
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _nameFocusNode.dispose();
    _professionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to edit'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_open_sharp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save the resume
            },
          )
        ],
      ),
      body: SafeArea(
        child: InteractiveViewer(
          // transformationController: _transformationController,
          constrained: true, // Set to false to allow it to expand freely
          boundaryMargin:
              const EdgeInsets.all(20.0), // Optional for boundary padding
          minScale: 0.5, // Minimum zoom scale
          maxScale: 3.0,
          child: const SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: TemporaryColumn(
                // nameFieldKey: nameFieldKey,
                // nameFocusNode: _nameFocusNode,
                // professionFocusNode: _professionFocusNode,
                // onFocusField: _zoomToField,
                ),
          ),
        ),
      ),
    );
  }
}

class TemporaryColumn extends StatefulWidget {
  // final GlobalKey nameFieldKey;
  // final FocusNode nameFocusNode;
  // final FocusNode professionFocusNode;
  // final Function(GlobalKey) onFocusField;

  const TemporaryColumn({
    super.key,
    // required this.nameFocusNode,
    // required this.professionFocusNode,
    // required this.nameFieldKey,
    // required this.onFocusField,
  });

  @override
  State<TemporaryColumn> createState() => _TemporaryColumnState();
}

class _TemporaryColumnState extends State<TemporaryColumn> {
  MyUser myUser = MyUser(
    fullName: 'Yihun Alemayehu',
    profession: 'Flutter Developer',
    bio:
        'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
        'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
        'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
        'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
        'my skills and learn from experienced professionals in a collaborative environment.',
    profilePic: File('assets/copy.jpg'),
    email: 'yankure01@gmail.com',
    address: 'Addis Ababa, Ethiopia',
    phoneNumber: '+251 982 39 40 38',
    linkedIn: 'linkedin.com/in/yihun-alemayehu',
    github: 'github.com/Yihun-Alemayehu',
    website: 'yihun-alemayehu.netlify.com/app',
  );

  // String fullName = 'Yihun Alemayehu';
  // String profession = 'Flutter Developer';
  // String bio =
  //     'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
  //     'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
  //     'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
  //     'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
  //     'my skills and learn from experienced professionals in a collaborative environment.';
  // String email = 'yankure01@gmail.com';
  // String address = 'Addis Ababa, Ethiopia';
  // String linkedIn = 'linkedin.com/in/yihun-alemayehu';
  // String phone = '+251 982 39 40 38';
  // String github = 'github.com/Yihun-Alemayehu';
  // String website = 'yihun-alemayehu.netlify.com/app';

  List education1 = [
    'Software Engineering',
    'Addis Ababa Science and Technology University',
    '05/2022',
    'Present',
    'Addis Ababa',
    'Internet Programming',
    'Object-oriented Programming',
    'Data Structures and Algorithms',
    'Mobile app development',
  ];
  List education2 = [
    'Mobile app development',
    'GDG AASTU',
    '10/2023',
    '03/2024',
    'Addis Ababa',
    'Flutter',
    'Dart',
  ];
  List workExperience1 = [
    'FLutter Developer',
    'Hex-labs',
    '10/2023',
    '01/2024',
    'Remote',
    'Implemented Payment Gateway Transition: Successfully '
        'facilitated the transition from Telebirr to Chapa as the payment '
        'gateway, streamlining transaction processes and enhancing '
        'payment reliability.',
  ];
  List workExperience2 = [
    'FLutter Developer',
    'Horan-Software',
    '08/2024',
    '11/2024',
    'Contract',
    'Implemented Firebase Integration: Successfully integrated Firebase into '
        'the application, enhancing real-time database management, user '
        'authentication, and analytics capabilities, leading to improved app '
        'performance and user engagement.',
  ];
  List workExperience3 = [
    'FLutter Developer',
    'Yize-Tech Ethiopia',
    '02/2023',
    '09/2023',
    'Remote',
    'Implemented Complex UI Designs: Successfully developed and integrated intricate, '
        'user-centric UI components, ensuring seamless functionality, responsiveness, and an '
        'engaging user experience across diverse devices and screen sizes.',
  ];
  List skills = [
    'Programming',
    'Flutter',
    'Dart',
    'Firebase',
    'Software development',
    'Figma',
    'State Management',
    'Graphics design',
    'Leadership',
    'Communication',
    'Photography',
  ];
  List personalProjects = [
    'Guadaye Mobile App',
    'AddisCart Mobile App',
    'GraceLink Mobile App',
    'Yize-chat Mobile App',
    'Nedemy Mobile App',
  ];
  List interests = [
    'Technology',
    'Design',
    'Photography',
    'Cooking',
    'Reading',
    'Gaming',
    'Artificial Intelligence',
    'Space science',
    'programming',
  ];
  List languages = [
    'English',
    'Full Professional Proficient',
    'Amharic',
    'Full Professional Proficient',
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  final List _iconsList1 = [
    Icons.email,
    Icons.pin_drop,
    Icons.dataset_linked_outlined,
  ];

  final List _iconsList2 = [
    Icons.phone,
    Icons.gite,
    Icons.web_sharp,
  ];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    _image = File(image!.path);
    setState(() {});
  }

  List _controllersList1 = [];
  List _controllersList2 = [];

  int _itemCount() {
    if (myUser.github != null && myUser.website != null) {
      return 3;
    } else if (myUser.github != null || myUser.website != null) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = myUser.fullName;
    _professionController.text = myUser.profession;
    _bioController.text = myUser.bio;
    _emailController.text = myUser.email;
    _addressController.text = myUser.address;
    _linkedInController.text = myUser.linkedIn!;
    _phoneController.text = myUser.phoneNumber;
    _githubController.text = myUser.github!;
    _websiteController.text = myUser.website!;

    _controllersList1
        .addAll([_emailController, _addressController, _linkedInController, 1]);

    _controllersList2.addAll([
      _phoneController,
      _githubController,
      _websiteController,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 49, 60, 75),
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Focus(
                      //   onFocusChange: (hasFocus) {
                      //     if (hasFocus) {
                      //       widget.onFocusField(widget.nameFieldKey);
                      //     }
                      //   },
                      //   child: TextField(
                      //     key: widget.nameFieldKey,
                      //     onTapOutside: (event) {
                      //       setState(() {
                      //         myUser = myUser.copyWith(
                      //             fullName: _nameController.text);
                      //       });
                      //       print(myUser.fullName);
                      //       FocusScope.of(context).unfocus();
                      //     },
                      //     onSubmitted: (value) {
                      //       setState(() {
                      //         myUser = myUser.copyWith(fullName: value);
                      //       });
                      //       print(myUser.fullName);
                      //     },
                      //     controller: _nameController,
                      //     focusNode: widget.nameFocusNode,
                      //     style: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     decoration: const InputDecoration(
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.zero,
                      //       border: InputBorder.none,
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      TextField(
                        onTapOutside: (event) {
                          setState(() {
                            myUser =
                                myUser.copyWith(fullName: _nameController.text);
                          });
                          print(myUser.fullName);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(fullName: value);
                          });
                          print(myUser.fullName);
                        },
                        controller: _nameController,
                        // focusNode: widget.nameFocusNode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        onTapOutside: (event) {
                          setState(() {
                            myUser = myUser.copyWith(
                                profession: _professionController.text);
                          });
                          print(myUser.profession);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(profession: value);
                          });
                          print(myUser.profession);
                        },
                        controller: _professionController,
                        // focusNode: widget.professionFocusNode,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 73, 150, 159),
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),

                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        maxLines: 10,
                        onTapOutside: (event) {
                          setState(() {
                            myUser = myUser.copyWith(bio: _bioController.text);
                          });
                          print(myUser.bio);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(bio: value);
                          });
                          print(myUser.bio);
                        },
                        controller: _bioController,
                        // focusNode: widget.professionFocusNode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //       context: context,
                      //       builder: (context) {
                      //         return EditField(
                      //           editableField: (value) {
                      //             setState(() {
                      //               myUser = myUser.copyWith(bio: value);
                      //             });
                      //           },
                      //           fieldName: 'About Yourself',
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 10),
                      //     child: Text(
                      //       myUser.bio,
                      //       style: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 8,
                      //       ),
                      //       overflow: TextOverflow.visible,
                      //       softWrap: true,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                _image == null
                    ? GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(myUser.profilePic.path),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: FileImage(_image!),
                      ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 34, 42, 51),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: myUser.linkedIn != null ? 3 : 2,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                              _iconsList1[index],
                              color: Colors.white,
                              size: 8,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                onTapOutside: (event) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList1[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList1[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList1[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList1[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList1[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList1[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                controller: _controllersList1[index],
                                // focusNode: widget.professionFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Phone number, github and website section
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 34, 42, 51),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: _itemCount(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                              _iconsList2[index],
                              color: Colors.white,
                              size: 8,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                onTapOutside: (event) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList2[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList2[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList2[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList2[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList2[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList2[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                controller: _controllersList2[index],
                                // focusNode: widget.professionFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20, top: 10),
                // width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'EDUCATION',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color.fromARGB(255, 73, 150, 159),
                                decorationThickness: 3,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[0] = value;
                                        });
                                      },
                                      fieldName: 'Field of study',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[1] = value;
                                        });
                                      },
                                      fieldName: 'Institution name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return DatePickFormField(
                                          editableField: (startDate, endDate) {
                                            setState(() {
                                              education1[2] = startDate;
                                              education1[3] = endDate;
                                            });
                                          },
                                          fieldName: 'Start Date',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    '${education1[2]} - ${education1[3]}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return EditField(
                                          editableField: (value) {
                                            setState(() {
                                              education1[4] = value;
                                            });
                                          },
                                          fieldName: 'Institution address',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    education1[4],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Courses',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[5] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[5],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[6] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[6],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[7] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[7],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education1[8] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education1[8],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            // const Row(
                            //   children: [
                            //     const Text(
                            //       '\u2022',
                            //       style: TextStyle(
                            //         fontStyle: FontStyle.italic,
                            //         color: Color.fromARGB(255, 73, 150, 159),
                            //         fontSize: 15,
                            //       ),
                            //     ),
                            //     Text('Internet Programming',
                            //         style: TextStyle(
                            //           fontSize: 8,
                            //         )),
                            //   ],
                            // ),
                            // const Row(
                            //   children: [
                            //     const Text(
                            //       '\u2022',
                            //       style: TextStyle(
                            //         fontStyle: FontStyle.italic,
                            //         color: Color.fromARGB(255, 73, 150, 159),
                            //         fontSize: 15,
                            //       ),
                            //     ),
                            //     Text('Internet Programming',
                            //         style: TextStyle(
                            //           fontSize: 8,
                            //         )),
                            //   ],
                            // ),
                            // const Row(
                            //   children: [
                            //     const Text(
                            //       '\u2022',
                            //       style: TextStyle(
                            //         fontStyle: FontStyle.italic,
                            //         color: Color.fromARGB(255, 73, 150, 159),
                            //         fontSize: 15,
                            //       ),
                            //     ),
                            //     Text('Internet Programming',
                            //         style: TextStyle(
                            //           fontSize: 8,
                            //         )),
                            //   ],
                            // ),
                            // const Row(
                            //   children: [
                            //     const Text(
                            //       '\u2022',
                            //       style: TextStyle(
                            //         fontStyle: FontStyle.italic,
                            //         color: Color.fromARGB(255, 73, 150, 159),
                            //         fontSize: 15,
                            //       ),
                            //     ),
                            //     Text('Internet Programming',
                            //         style: TextStyle(
                            //           fontSize: 8,
                            //         )),
                            //   ],
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education2[0] = value;
                                        });
                                      },
                                      fieldName: 'Field of study',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education2[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education2[1] = value;
                                        });
                                      },
                                      fieldName: 'Institution name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                education2[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${education2[2]} - ${education2[3]}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return EditField(
                                          editableField: (value) {
                                            setState(() {
                                              education2[4] = value;
                                            });
                                          },
                                          fieldName: 'Institution address',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    education2[4],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Courses',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education2[5] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(education2[5],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          education2[6] = value;
                                        });
                                      },
                                      fieldName: 'Courses',
                                    );
                                  },
                                );
                              },
                              child: Text(education2[6],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'WORK EXPERIENCE',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color.fromARGB(255, 73, 150, 159),
                                decorationThickness: 3,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience1[0] = value;
                                        });
                                      },
                                      fieldName: 'Work Position',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience1[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience1[1] = value;
                                        });
                                      },
                                      fieldName: 'Company',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience1[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${workExperience1[2]} - ${workExperience1[3]}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return EditField(
                                          editableField: (value) {
                                            setState(() {
                                              workExperience1[4] = value;
                                            });
                                          },
                                          fieldName: 'Work type',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    workExperience1[4],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience1[5] = value;
                                        });
                                      },
                                      fieldName: 'Achievement',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience1[5],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience2[0] = value;
                                        });
                                      },
                                      fieldName: 'Work Position',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience2[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience2[1] = value;
                                        });
                                      },
                                      fieldName: 'Company',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience2[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${workExperience2[2]} - ${workExperience2[3]}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return EditField(
                                          editableField: (value) {
                                            setState(() {
                                              workExperience2[4] = value;
                                            });
                                          },
                                          fieldName: 'Work type',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    workExperience2[4],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience2[5] = value;
                                        });
                                      },
                                      fieldName: 'Achievement',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience2[5],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience3[0] = value;
                                        });
                                      },
                                      fieldName: 'Work Position',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience3[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience3[1] = value;
                                        });
                                      },
                                      fieldName: 'Company',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience3[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${workExperience3[2]} - ${workExperience3[3]}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return EditField(
                                          editableField: (value) {
                                            setState(() {
                                              workExperience3[4] = value;
                                            });
                                          },
                                          fieldName: 'Work type',
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    workExperience3[4],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          workExperience3[5] = value;
                                        });
                                      },
                                      fieldName: 'Achievement',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                workExperience3[5],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // SKILLS Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SKILLS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 73, 150, 159),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 73, 150, 159),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[0] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[0],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[1] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[1],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[2] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[2],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[3] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[3],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[4] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[4],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[5] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[5],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[6] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[6],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[7] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[7],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[8] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[8],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[9] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[9],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          skills[10] = value;
                                        });
                                      },
                                      fieldName: 'Skill',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 73, 150, 159),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skills[10],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PERSONAL PROJECTS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 73, 150, 159),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 73, 150, 159),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          personalProjects[0] = value;
                                        });
                                      },
                                      fieldName: 'Project Name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                personalProjects[0],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          personalProjects[1] = value;
                                        });
                                      },
                                      fieldName: 'Project Name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                personalProjects[1],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          personalProjects[2] = value;
                                        });
                                      },
                                      fieldName: 'Project Name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                personalProjects[2],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          personalProjects[3] = value;
                                        });
                                      },
                                      fieldName: 'Project Name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                personalProjects[3],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          personalProjects[4] = value;
                                        });
                                      },
                                      fieldName: 'Project Name',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                personalProjects[4],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LANGUAGES',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 73, 150, 159),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 73, 150, 159),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          languages[0] = value;
                                        });
                                      },
                                      fieldName: 'language',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                languages[0],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          languages[1] = value;
                                        });
                                      },
                                      fieldName: 'Proficiency',
                                    );
                                  },
                                );
                              },
                              child: Text(
                                languages[1],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return EditField(
                                        editableField: (value) {
                                          setState(() {
                                            languages[2] = value;
                                          });
                                        },
                                        fieldName: 'language',
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  languages[2],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return EditField(
                                        editableField: (value) {
                                          setState(() {
                                            languages[3] = value;
                                          });
                                        },
                                        fieldName: 'Proficiency',
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  languages[3],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'INTERESTS',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 73, 150, 159),
                            decorationThickness: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 73, 150, 159),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[0] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[0],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[1] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[1],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[2] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[2],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[3] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[3],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[4] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[4],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[5] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[5],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[6] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[6],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[7] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[7],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditField(
                                      editableField: (value) {
                                        setState(() {
                                          interests[8] = value;
                                        });
                                      },
                                      fieldName: 'interest',
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                margin:
                                    const EdgeInsets.only(right: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 73, 150, 159),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  interests[8],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Card(
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tap on any section to edit',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: double.infinity,
          color: const Color.fromARGB(255, 49, 60, 75),
          child: const Padding(
            padding: EdgeInsets.only(right: 30, left: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yihun Alemayehu',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        'Enthusiastic and innovative Junior Flutter Developer and Graphics Designer ready to bring a unique blend '
                        'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
                        'I specialize in crafting visually stunning and seamlessly functional mobile applications. With apassion for '
                        'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
                        'my skills and learn from experienced professionals in a collaborativeenvironment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/copy.jpg'),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          color: const Color.fromARGB(255, 34, 42, 51),
          child: const Padding(
            padding: EdgeInsets.only(right: 30, left: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'yankure01@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+251 982 39 40 38',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Addis Ababa, Ethiopia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.gite,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'github.com/Yihun-Alemayehu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dataset_linked_outlined,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'linkedin.com/in/yihun-alemayehu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.web_sharp,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'yihun-alemayehu.netlify.com/app',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20),
                // width: MediaQuery.of(context).size.width * 0.6,
                child: const Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EDUCATION'),
                            Text(
                              'Software Engineering',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Addis Ababa Science and Technology University',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05/2022 - Present',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile App Development',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'GDG AASTU',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05/2022 - Present',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('WORK EXPERIENCE'),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Hex-labs',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '10/2023 - 01/2024',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Improved Efficiency: Optimized widget rendering in a critical feature'
                              ' of the mobile app, reducing load times by 20% and enhancing overall user '
                              'experience.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Payment Gateway Transition: Successfully'
                              'facilitated the transition from Telebirr to Chapa as the payment'
                              'gateway, streamlining transaction processes and enhancing'
                              'payment reliability.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Horan-software',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '08/2024 - 11/2024',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Contract',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Firebase Integration: Successfully integrated Firebase into'
                              'the application, enhancing real-time database management, user'
                              'authentication, and analytics capabilities, leading to improved app'
                              'performance and user engagement.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Yize-Tech Ethiopia',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '02/2023 - 09/2023',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Complex UI Designs: Successfully developed and integrated intricate,'
                              'user-centric UI components, ensuring seamless functionality, responsiveness, and an'
                              'engaging user experience across diverse devices and screen sizes.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // SKILLS Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SKILLS'),
                        Wrap(
                          spacing: 4,
                          children: [
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Flutter',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Dart',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Firebase',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Software development',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Figma',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'State Management',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Graphics design',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Leadership',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Communication',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Photography',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PERSONAL PROJECTS'),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            Text(
                              'Guadaye Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'AddisCart Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'GraceLink Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Yize-chat Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Nedemy Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LANGUAGES'),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            Text(
                              'English',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Full Professional Proficient',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amharic',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Full Professional Proficient',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('INTERESTS'),
                        Wrap(
                          spacing: 4,
                          children: [
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Space science',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'programming',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'photography',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'reading',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Artificial Intelligence',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
