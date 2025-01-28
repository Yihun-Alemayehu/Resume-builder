import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_resume/features/resume/Presentation/screens/main_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkDeviceSupport();
    _authenticateOnStartup();
  }

  Future<void> _checkDeviceSupport() async {
    final isSupported = await auth.isDeviceSupported();
    setState(() {
      _supportState = isSupported ? _SupportState.supported : _SupportState.unsupported;
    });
  }

  Future<void> _authenticateOnStartup() async {
    await Future.delayed(const Duration(seconds: 1)); // Optional delay for smooth UX
    final authenticated = await _authenticate();
    if (authenticated) {
      _navigateToHomeScreen();
    }
  }

  Future<bool> _authenticate() async {
    try {
      setState(() {
        _isAuthenticating = true;
      });
      final authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );
      setState(() {
        _isAuthenticating = false;
      });
      return authenticated;
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
      debugPrint('Error during authentication: ${e.message}');
      return false;
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _supportState == _SupportState.unknown
            ? const CircularProgressIndicator()
            : _supportState == _SupportState.unsupported
                ? const Text('This device does not support biometric authentication')
                : _isAuthenticating
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final authenticated = await _authenticate();
                          if (authenticated) {
                            _navigateToHomeScreen();
                          }
                        },
                        child: const Text('Authenticate'),
                      ),
      ),
    );
  }
}


enum _SupportState {
  unknown,
  supported,
  unsupported,
}
