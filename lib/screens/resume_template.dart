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
        child: InteractiveViewer(
          child: TemporaryColumn(),
        ),
      ),
    );
  }
}

class TemporaryColumn extends StatelessWidget {
  const TemporaryColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 49, 60, 75),
          child: const Padding(
            padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yihun Alemayehu',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                            color: Color.fromARGB(255, 73, 150, 159),
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
                          'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
                          'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
                          'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
                          'my skills and learn from experienced professionals in a collaborative environment.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/copy.jpg'),
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
                child: const Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 8,
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
                            Icons.pin_drop,
                            color: Colors.white,
                            size: 8,
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
                            Icons.dataset_linked_outlined,
                            color: Colors.white,
                            size: 8,
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
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 34, 42, 51),
                child: const Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 8,
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
                      Row(
                        children: [
                          Icon(
                            // Icons.gite,
                            const IconData(0xe0be),
                            color: Colors.white,
                            size: 8,
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
                      Row(
                        children: [
                          Icon(
                            Icons.web_sharp,
                            color: Colors.white,
                            size: 8,
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
                child: const Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Software Engineering',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Addis Ababa Science and Technology University',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05/2022 - Present',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            Text('Internet Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                )),
                            Text('Internet Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                )),
                            Text('Internet Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                )),
                            Text('Internet Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                ),),
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
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile app development',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'GDG AASTU',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '10/2023 - 03/2024',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            Text('Flutter',
                                style: TextStyle(
                                  fontSize: 8,
                                )),
                            Text('Dart',
                                style: TextStyle(
                                  fontSize: 8,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Hex-labs',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '10/2023 - 01/2024',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Payment Gateway Transition: Successfully '
                              'facilitated the transition from Telebirr to Chapa as the payment '
                              'gateway, streamlining transaction processes and enhancing '
                              'payment reliability.',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Horan-software',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '08/2024 - 11/2024',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Contract',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Firebase Integration: Successfully integrated Firebase into '
                              'the application, enhancing real-time database management, user '
                              'authentication, and analytics capabilities, leading to improved app '
                              'performance and user engagement.',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Yize-Tech Ethiopia',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '02/2023 - 09/2023',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 73, 150, 159),
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Complex UI Designs: Successfully developed and integrated intricate, '
                              'user-centric UI components, ensuring seamless functionality, responsiveness, and an '
                              'engaging user experience across diverse devices and screen sizes.',
                              style: const TextStyle(
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
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Programming',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Flutter',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Dart',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Firebase',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Software development',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Figma',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'State Management',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Graphics design',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Leadership',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Communication',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              margin:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 73, 150, 159),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Photography',
                                style: const TextStyle(
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
                        Text(
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
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            Text(
                              'Guadaye Mobile App',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'AddisCart Mobile App',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'GraceLink Mobile App',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Yize-chat Mobile App',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Nedemy Mobile App',
                              style: TextStyle(
                                fontSize: 12,
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
                        Text(
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
                        SizedBox(
                          height: 10,
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
                        SizedBox(
                          height: 6,
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
                        Text(
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
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 4,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 150, 159),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Space science',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 150, 159),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'programming',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 150, 159),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'photography',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 150, 159),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'reading',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 150, 159),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Artificial Intelligence',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
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
        ),
      ],
    );
  }
}
