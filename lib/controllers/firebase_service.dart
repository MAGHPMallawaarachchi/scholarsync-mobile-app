import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future<String> uploadImage(File imageFile, String imagePath) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child(imagePath);
      final UploadTask uploadTask = storageRef.putFile(imageFile);

      await uploadTask.whenComplete(() => null);

      final String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return "";
    }
  }
}
