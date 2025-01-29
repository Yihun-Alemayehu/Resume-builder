import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: const DefaultTabController(
        length: 10,
        child: SafeArea(
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                physics: AlwaysScrollableScrollPhysics(),
                indicatorWeight: 6,
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Personal'),
                  Tab(text: 'Education'),
                  Tab(text: 'Work'),
                  Tab(text: 'Language'),
                  Tab(text: 'Certificate'),
                  Tab(text: 'Award'),
                  Tab(text: 'Skill'),
                  Tab(text: 'Projects'),
                  Tab(text: 'Interest'),
                  Tab(text: 'Reference'),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [
                    Text('Personal'),
                    Text('Education'),
                    Text('Work'),
                    Text('Language'),
                    Text('Certificate'),
                    Text('Award'),
                    Text('Skill'),
                    Text('Projects'),
                    Text('Interest'),
                    Text('Reference'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
