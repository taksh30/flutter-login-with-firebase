import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailCtr = TextEditingController();

  @override
  void dispose() {
    _emailCtr.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailCtr.text.trim());
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  e.message.toString(),
                ),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Enter your email and we will send you a password reset link.'),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailCtr,
                decoration: InputDecoration(
                  constraints: const BoxConstraints(maxWidth: 400),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple)),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  // border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                passwordReset();
              },
              color: Colors.deepPurple.shade300,
              child: const Text('Reset Password'),
            )
          ],
        ),
      ),
    );
  }
}
