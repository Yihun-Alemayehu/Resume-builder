import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                  child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/copy.jpg'),
                ),
                title: Text('Yihun Alemayehu'),
                trailing: Icon(Icons.arrow_forward_ios),
                
              ))
            ],
          ),
        ));
  }
}
