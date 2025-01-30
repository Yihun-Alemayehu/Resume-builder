import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class CertificateTab extends StatefulWidget {
  const CertificateTab({super.key});

  @override
  State<CertificateTab> createState() => _CertificateTabState();
}

class _CertificateTabState extends State<CertificateTab> {
  List<CertificateModel> _certificates = [
    CertificateModel(
      certificateName: 'Certificate Name',
      issuedDate: 'Issued Date',
    )
  ];

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

  void _editCertificate(int index) {
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
                  hintText: 'Certificate Name',
                  function: (val) {
                    setState(() {
                      _certificates[index] = _certificates[index].copyWith(
                        certificateName: val,
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    _certificates[index] = _certificates[index].copyWith(
                      issuedDate: value,
                    );
                  },
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
            children: List.generate(_certificates.length, (index) {
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
                              _certificates[index].certificateName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _certificates[index].issuedDate.toString(),
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
                              onPressed: () => _editCertificate(index),
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
                                  _certificates.removeAt(index);
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
            _certificates.add(
              CertificateModel(
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
