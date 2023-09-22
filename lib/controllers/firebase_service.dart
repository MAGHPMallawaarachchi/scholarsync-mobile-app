import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  Future<String?> uploadImage(File imageFile, String imagePath) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child(imagePath);
      final TaskSnapshot taskSnapshot = await storageRef.putFile(imageFile);

      final String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (error) {
      log(error.toString() as num);
      return null;
    }
  }
}
