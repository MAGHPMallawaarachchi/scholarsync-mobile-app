import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/lecturer.dart';

class LecturerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Lecturer>> getLecturers(String category) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('lecturers')
          .where('department', isEqualTo: category) // Add the filter here
          .get();

      return querySnapshot.docs
          .map((doc) => Lecturer.fromSnapshot(doc))
          .toList();
    } catch (error) {
      // Handle the error
      return [];
    }
  }
}
