import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/common_text_field.dart';
import 'package:login_with_firebase/constants.dart';
import 'package:login_with_firebase/pages/forgot_pw_page.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();

  Future _signIn() async {
    try {
      if (_emailCtr.text.isNotEmpty && _passCtr.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            });

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailCtr.text.trim(),
          password: _passCtr.text.trim(),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text(
                  'Enter the fields',
                ),
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: Constants().boxDecoration,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    'Hello Again!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 43),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Welcome Back Buddy',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CommonTextField(
                    controller: _emailCtr,
                    obscureText: false,
                    text: 'Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextField(
                    controller: _passCtr,
                    obscureText: true,
                    text: 'Password',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 270,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 40),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _signIn();
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Not a member?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
