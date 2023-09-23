import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/kuppi.dart';

class KuppisService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<KuppiSession>> getKuppiSessions() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('kuppiSessions').get();

      return querySnapshot.docs
          .map((doc) => KuppiSession.fromSnapshot(doc))
          .toList();
    } catch (error) {
      log("Error fetching kuppi sessions: $error");
      return [];
    }
  }

  Stream<List<KuppiSession>> listenToKuppiSessions() {
    return _firestore.collection('kuppiSessions').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => KuppiSession.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> createKuppiSession(KuppiSession kuppiSession) async {
    try {
      await _firestore.collection('kuppiSessions').add(kuppiSession.toJson());
    } catch (error) {
      log("Error creating kuppi session: $error");
    }
  }

  Future<void> updateKuppiSession(KuppiSession kuppiSession) async {
    try {
      await _firestore
          .collection('kuppiSessions')
          .doc(kuppiSession.id)
          .update(kuppiSession.toJson());
    } catch (error) {
      log("Error updating kuppi session: $error");
    }
  }

  Future<void> deleteKuppiSession(String id) async {
    try {
      await _firestore.collection('kuppiSessions').doc(id).delete();
    } catch (error) {
      log("Error deleting kuppi session: $error");
    }
  }

  Stream<List<String>> streamKuppiSessionImageURLs() {
    return _firestore.collection('kuppiSessions').snapshots().map((snapshot) {
      final List<String> imageUrls = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('imageUrl') && data['imageUrl'] is String) {
          final String imageUrl = data['imageUrl'];

          if (imageUrl.isNotEmpty) {
            imageUrls.add(imageUrl);
          }
        }
      }
      return imageUrls;
    }).handleError((error) {
      log('Error fetching image URLs: $error');
      return [];
    });
  }
}
