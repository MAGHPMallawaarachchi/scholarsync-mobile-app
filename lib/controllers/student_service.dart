import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarsync/model/student.dart';
import '../model/project.dart';

class StudentService {
  CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');

  Future<List<Student>> getStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentCollection.get();
      List<Student> students =
          querySnapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
      return students;
    } catch (e) {
      // print('cant get students: ' + e.toString());
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
            id: querySnapshot.docs[0].id,
            email: userData['email'],
            studentId: userData['studentId'],
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            degreeProgram: userData['degreeProgram'],
            batch: userData['batch'],
          );
        }
      }
    } catch (e) {
      // print('Error fetching user data: $e');
    }
    return null;
  }

  static Future<List<Project>> fetchProjectsForStudent() async {
    try {
      Future<Student?> student = fetchUserData();
      String studentId = (await student)!.id;

      final projectCollection = FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .collection('projects');

      final querySnapshot = await projectCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        final projects =
            querySnapshot.docs.map((doc) => Project.fromSnapshot(doc)).toList();

        return projects;
      } else {
        return [];
      }
    } catch (e) {
      // print('Error fetching projects: $e');
      rethrow;
    }
  }

  static Future<void> createNewProject(Project project) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final studentId = querySnapshot.docs[0].id;

          final projectCollection = FirebaseFirestore.instance
              .collection('students')
              .doc(studentId)
              .collection('projects');

          await projectCollection.add({
            'name': project.name,
            'date': project.date,
            'link': project.link,
          });
        }
      }
    } catch (e) {
      // Handle errors here
    }
  }
}
