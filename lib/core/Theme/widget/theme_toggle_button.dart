import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/core/Theme/bloc/theme_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Icon(
            state.themeData.brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          );
        },
      ),
      onPressed: () {
        context.read<ThemeBloc>().add(ToggleThemeEvent());
      },
    );
  }
}
