import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarsync/model/student.dart';
import '../model/project.dart';

class StudentController {
  CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');

  Future<List<Student>> getStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentCollection.get();
      List<Student> students =
          querySnapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
      return students;
    } catch (e) {
      print('cant get students: ' + e.toString());
      return [];
    }
  }

  static Future<Student?> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final userData = querySnapshot.docs[0].data();

          // Map the Firestore data to a Student object
          return Student(
            email: userData['email'],
            studentId: userData['studentId'],
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            degreeProgram: userData['degreeProgram'],
            batch: userData['batch'],
            projects: userData['projects'],
          );
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    return null;
  }
}
