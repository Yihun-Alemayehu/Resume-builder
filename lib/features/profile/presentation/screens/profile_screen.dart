import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
  }

  bool isExpanded = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;
  bool isExpanded5 = false;
  bool isExpanded6 = false;
  bool isExpanded7 = false;
  bool isExpanded8 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.red,
                  )),
              onPressed: () {
                context.read<UserProfileBloc>().add(const DeleteUserProfile());
              },
              child: const Text('Delete'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.green,
                  )),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is UserProfileDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile deleted successfully')));
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded ||
              state is UserProfileUpdated ||
              state is UserProfileSaved) {
            final userProfile = (state as UserProfileLoaded).user;
            print(
                '-------------USER PROFILE FROM PROFILE SCREEN --------------------------------');
            log(userProfile.toString());
            print(
                '-------------USER PROFILE FROM PROFILE SCREEN --------------------------------');
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(userProfile.userdata.profilePic),
                  ),
                  title: Text(state.user.userdata.fullName),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Card(
                        child: Column(
                          children: [
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded = value;
                                });
                              },
                              trailing: isExpanded
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.person),
                              title: const Text(
                                'Personal',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListTile(
                                  title: Text(
                                      'Profession: ${userProfile.userdata.profession}'),
                                ),
                                ListTile(
                                  title:
                                      Text('Bio: ${userProfile.userdata.bio}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Email: ${userProfile.userdata.email}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Phone: ${userProfile.userdata.phoneNumber}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Address: ${userProfile.userdata.address}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'LinkedIn: ${userProfile.userdata.linkedIn}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Github: ${userProfile.userdata.github}'),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded2 = value;
                                });
                              },
                              trailing: isExpanded2
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.school),
                              title: const Text(
                                'Education',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProfile.education.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          'Field of Study: ${userProfile.education[index].fieldOfStudy}'),
                                      subtitle: Text(
                                          'Institution: ${userProfile.education[index].institutionName}'),
                                      trailing: Text(
                                          '${userProfile.education[index].startDate} - ${userProfile.education[index].endDate}'),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded3 = value;
                                });
                              },
                              trailing: isExpanded3
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.work),
                              title: const Text(
                                'Work Experience',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProfile.workExperience.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          'Job Title: ${userProfile.workExperience[index].jobTitle}'),
                                      subtitle: Text(
                                          'company Name: ${userProfile.workExperience[index].companyName}'),
                                      trailing: Text(
                                          '${userProfile.education[index].startDate} - ${userProfile.education[index].endDate}'),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded4 = value;
                                });
                              },
                              trailing: isExpanded4
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.redeem),
                              title: const Text(
                                'Certificates',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProfile.certificates.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(userProfile
                                          .certificates[index].certificateName),
                                      subtitle: Text(userProfile
                                          .certificates[index].issuedDate),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded5 = value;
                                });
                              },
                              trailing: isExpanded5
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.emoji_events),
                              title: const Text(
                                'Awards',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProfile.awards.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          userProfile.awards[index].awardName),
                                      subtitle: Text(
                                          userProfile.awards[index].issuedDate),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded5 = value;
                                });
                              },
                              trailing: isExpanded5
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.person),
                              title: const Text(
                                'Skills',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                Wrap(
                                  spacing: 4,
                                  alignment: WrapAlignment.start,
                                  children: List.generate(
                                    userProfile.skills.length,
                                    (index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        margin: const EdgeInsets.only(
                                            right: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          userProfile.skills[index],
                                          style: const TextStyle(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded6 = value;
                                });
                              },
                              trailing: isExpanded6
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.cases),
                              title: const Text(
                                'Projects',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      userProfile.personalProjects.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(userProfile
                                          .personalProjects[index].name),
                                      subtitle: Text(userProfile
                                          .personalProjects[index].description),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded7 = value;
                                });
                              },
                              trailing: isExpanded7
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.interests),
                              title: const Text(
                                'Interests',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                Wrap(
                                  spacing: 4,
                                  alignment: WrapAlignment.start,
                                  children: List.generate(
                                    userProfile.interests.length,
                                    (index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        margin: const EdgeInsets.only(
                                            right: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          userProfile.interests[index],
                                          style: const TextStyle(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded8 = value;
                                });
                              },
                              trailing: isExpanded8
                                  ? const Icon(Icons.expand_less)
                                  : const Icon(Icons.expand_more),
                              leading: const Icon(Icons.recommend_outlined),
                              title: const Text(
                                'References',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProfile.references.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title:
                                          Text(userProfile.references[index]),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text('No Data Available, please add profile !'),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .9, 50),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ));
                    },
                    child: const Text('Add Profile'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
