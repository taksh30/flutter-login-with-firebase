import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  final _confirmPassCtr = TextEditingController();
  final _firstNameCtr = TextEditingController();
  final _lastNameCtr = TextEditingController();
  final _ageCtr = TextEditingController();

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    _confirmPassCtr.dispose();
    _firstNameCtr.dispose();
    _lastNameCtr.dispose();
    _ageCtr.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtr.text.trim(),
        password: _passCtr.text.trim(),
      );

      addUserDetails(
        _firstNameCtr.text.trim(),
        _lastNameCtr.text.trim(),
        _emailCtr.text.trim(),
        int.parse(_ageCtr.text.trim()),
      );
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passCtr.text.trim() == _confirmPassCtr.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                const Text(
                  'Hello There!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 43),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Register below with your details',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _firstNameCtr,
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
                      hintText: 'First Name',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _lastNameCtr,
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
                      hintText: 'Last Name',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _ageCtr,
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
                      hintText: 'Age',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                  height: 10,
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _confirmPassCtr,
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
                      hintText: 'Confirm Password',
                    ),
                  ),
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
                          signUp();
                        },
                        child: const Text(
                          'Sign Up',
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
                        'I am a member!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Login Now',
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
