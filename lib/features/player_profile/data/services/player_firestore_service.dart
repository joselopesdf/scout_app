import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerFirestoreService {
  PlayerFirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _players =>
      _firestore.collection('players');

  Future<DocumentSnapshot<Map<String, dynamic>>> findByUserId(String userId) {
    return _players.doc(userId).get();
  }

  Future<void> create({
    required String userId,
    required Map<String, dynamic> data,
  }) {
    return _players.doc(userId).set(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> list() {
    return _players.orderBy('fullName').get();
  }
}
