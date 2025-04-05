import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/core/Theme/bloc/theme_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header (optional)
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'My Resume App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Drawer items
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Add navigation logic here (e.g., Navigator.push())
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Add navigation logic here (e.g., Navigator.push())
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Add navigation logic here (e.g., Navigator.push())
            },
          ),
          const Divider(),
          // Theme Toggle Button
          ListTile(
            title: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Text(
                  state.themeData.brightness == Brightness.dark
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    state.themeData.brightness == Brightness.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
