import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch user data by document ID
  Future<Map<String, dynamic>?> getUserData(String documentId) async {
    DocumentSnapshot doc = await _db.collection('users').doc(documentId).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  // Update user data by document ID
  Future<void> updateUserData(
      String documentId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(documentId).update(data);
  }

  Stream<List<QueryDocumentSnapshot>> getUserDocuments() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
