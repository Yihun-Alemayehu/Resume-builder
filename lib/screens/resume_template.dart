import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResumeTemplate extends StatefulWidget {
  const ResumeTemplate({super.key});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                padding:
                    EdgeInsets.only(right: 30, left: 20, top: 10, bottom: 10),
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
                    child: Column(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
