import 'package:flutter/material.dart';
import 'package:login_with_firebase/auth/firestore_service.dart';
import 'package:login_with_firebase/components/common_text_field.dart';
import 'package:login_with_firebase/constants.dart';

class UpdateUserDetails extends StatefulWidget {
  final String documentId;

  const UpdateUserDetails({super.key, required this.documentId});

  @override
  UpdateUserDetailsState createState() => UpdateUserDetailsState();
}

class UpdateUserDetailsState extends State<UpdateUserDetails> {
  final FirestoreService _firestoreService = FirestoreService();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();

    _firestoreService.getUserData(widget.documentId).then((data) {
      if (data != null) {
        setState(() {
          _firstNameController.text = data['first name'];
          _lastNameController.text = data['last name'];
          _ageController.text = data['age'].toString();
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Update User Data',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: Constants().boxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTextField(
                  controller: _firstNameController,
                  obscureText: false,
                  text: 'First Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: _lastNameController,
                  obscureText: false,
                  text: 'Last Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: _ageController,
                  obscureText: false,
                  text: 'Age',
                ),
                const SizedBox(height: 20),
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
                    onPressed: () async {
                      await _firestoreService
                          .updateUserData(widget.documentId, {
                        'first name': _firstNameController.text,
                        'last name': _lastNameController.text,
                        'age': int.tryParse(_ageController.text) ?? 0,
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
