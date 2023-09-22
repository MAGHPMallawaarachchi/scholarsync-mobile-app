import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if the user is a club based on their email
  Future<bool> checkIfUserIsClub() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection('clubs')
            .where('email', isEqualTo: user.email)
            .get();

        return querySnapshot.docs.isNotEmpty;
      }
      return false;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
