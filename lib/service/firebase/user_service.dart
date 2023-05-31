import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class UserServier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<User>> getAllUsers() async {
    final QuerySnapshot snapshot = await firestore.collection('users').get();
    final List<User> users = snapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
  }

  Future<User?> getUserByEmail(String email) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.first.data() as Map<String, dynamic>;
      return User.fromMap(userData);
    } else {
      return null;
    }
  }

  Future<List<User>> getUsersByInterest(String interest) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .where('interests', arrayContains: interest)
        .get();
    final List<User> users = snapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
  }

  Future<void> addUser(User user) async {
    final Map<String, dynamic> userData = user.toMap();
    await firestore.collection('users').doc(user.email).set(userData);
  }

  Future<void> updateUser(User user) async {
    final Map<String, dynamic> userData = user.toMap();
    await firestore.collection('users').doc(user.email).update(userData);
  }

  Future<void> deleteUser(String email) async {
    await firestore.collection('users').doc(email).delete();
  }
}
