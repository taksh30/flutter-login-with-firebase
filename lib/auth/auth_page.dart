import 'package:flutter/material.dart';
import 'package:login_with_firebase/pages/login_screen.dart';
import 'package:login_with_firebase/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: () {
          toggleScreens();
        },
      );
    } else {
      return RegisterPage(
        showLoginPage: () {
          toggleScreens();
        },
      );
    }
  }
}
