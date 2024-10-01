import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });

    try {
      if (_emailCtr.text.isNotEmpty && _passCtr.text.isNotEmpty) {
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
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
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
                          borderSide:
                              const BorderSide(color: Colors.deepPurple)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passCtr,
                    obscureText: true,
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
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      // border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
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
                        style: TextStyle(color: Colors.blueGrey),
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
                          minimumSize: const Size(405, 50),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          signIn();
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
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
