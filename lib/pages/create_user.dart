import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/common_text_field.dart';
import 'package:login_with_firebase/constants.dart';

class CreateUser extends StatefulWidget {
  final VoidCallback showLoginPage;
  const CreateUser({super.key, required this.showLoginPage});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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

  Future _signUp() async {
    if (_passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtr.text.trim(),
        password: _passCtr.text.trim(),
      );

      _addUserDetails(
        _firstNameCtr.text.trim(),
        _lastNameCtr.text.trim(),
        _emailCtr.text.trim(),
        int.parse(_ageCtr.text.trim()),
      );
    }
  }

  Future _addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'email': email,
    });
  }

  bool _passwordConfirmed() {
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
        child: Container(
          decoration: Constants().boxDecoration,
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
                  CommonTextField(
                    controller: _firstNameCtr,
                    obscureText: false,
                    text: 'First Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _lastNameCtr,
                    obscureText: false,
                    text: 'Last name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _ageCtr,
                    obscureText: false,
                    text: 'Age',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _emailCtr,
                    obscureText: false,
                    text: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _passCtr,
                    obscureText: true,
                    text: 'Password',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _confirmPassCtr,
                    obscureText: true,
                    text: 'Confirm Password',
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
                            _signUp();
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
