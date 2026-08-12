import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestoreService {
  UserFirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users {
    return _firestore.collection('users');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> findByUid(String uid) {
    return _users.doc(uid).get();
  }

  Future<void> create({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    return _users.doc(uid).set(data);
  }

  Future<void> update({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    return _users.doc(uid).update(data);
  }

  Future<void> delete(String uid) {
    return _users.doc(uid).delete();
  }
}
