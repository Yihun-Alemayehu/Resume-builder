import 'package:flutter/material.dart';

class SizeCal extends StatefulWidget {
  const SizeCal({super.key});

  @override
  State<SizeCal> createState() => _SizeCalState();
}

class _SizeCalState extends State<SizeCal> {

  // 360 && 820

  Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return Scaffold(
      body: Center(
        child:
            Text('Screen Size: ${screenSize.width} x ${screenSize.height} dp'),
      ),
    );
  }
}
