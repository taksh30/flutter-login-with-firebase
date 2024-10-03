import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/auth/firestore_service.dart';
import 'package:login_with_firebase/constants.dart';
import 'package:login_with_firebase/pages/update_user_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String? currentUserDocId;

  Future<void> _deleteUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserDocId)
        .delete();

    await user?.delete();

    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          user?.email ?? 'Not Available',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _deleteUser();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              if (currentUserDocId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateUserDetails(documentId: currentUserDocId ?? ''),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: Constants().boxDecoration,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<List<QueryDocumentSnapshot>>(
                  stream: FirestoreService().getUserDocuments(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }

                    final docs = snapshot.data ?? [];

                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.black87,
                        );
                      },
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];

                        if (doc['email'] == user?.email) {
                          currentUserDocId = doc.id;
                        }

                        return ListTile(
                          title:
                              Text(doc['first name'] + '\t' + doc['last name']),
                          subtitle: Text(doc['age'].toString()),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
