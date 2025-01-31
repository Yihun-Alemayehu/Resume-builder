import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class CertificateTab extends StatefulWidget {
  const CertificateTab({super.key});

  @override
  State<CertificateTab> createState() => _CertificateTabState();
}

class _CertificateTabState extends State<CertificateTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      dateController.text = picked.toString().split(' ')[0];
    }
  }

  void _editCertificate(
      {required int index, required CertificateModel certificate}) {
    nameController.text = certificate.certificateName;
    dateController.text = certificate.issuedDate;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Edit Certificate'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  controller: nameController,
                  hintText: 'Certificate Name',
                  function: (val) {
                    setState(() {
                      nameController.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _selectDate,
                      icon: const Icon(Icons.date_range),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    hintText: 'Select start and end date',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  context.read<UserProfileDataCubit>().updateCertificate(
                    index: index,
                    certificateModel: CertificateModel(
                      certificateName: nameController.text,
                      issuedDate: dateController.text,
                    ));
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
      body: BlocBuilder<UserProfileDataCubit, UserProfileDataState>(
        builder: (context, state) {
          if (state is UserProfileDataLoaded) {
            final userProfile = state.userProfile;
            return SingleChildScrollView(
              primary: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children:
                      List.generate(userProfile.certificates.length, (index) {
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
                                    userProfile
                                        .certificates[index].certificateName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userProfile.certificates[index].issuedDate
                                        .toString(),
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
                                    onPressed: () => _editCertificate(
                                      index: index,
                                      certificate: CertificateModel(
                                          certificateName: nameController.text,
                                          issuedDate: dateController.text),
                                    ),
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
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removeCertificate(index: index);
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Language
          setState(() {
            context.read<UserProfileDataCubit>().addCertificate(
                  certificate: const CertificateModel(
                    certificateName: 'Certificate Name',
                    issuedDate: 'Issued Date',
                  ),
                );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
