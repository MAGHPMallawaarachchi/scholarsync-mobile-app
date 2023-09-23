import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarsync/controllers/firebase_service.dart';
import 'package:scholarsync/model/student.dart';
import '../model/project.dart';
import '../utils/utils.dart';

class StudentService {
  CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');
  final User user = FirebaseAuth.instance.currentUser!;
  final FirebaseService _firebaseService = FirebaseService();
  final Utils _utils = Utils();

  Future<List<Student>> getStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentCollection.get();
      List<Student> students =
          querySnapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
      return students;
    } catch (e) {
      return [];
    }
  }

  Future<Student?> fetchStudentData() async {
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
            profileImageUrl: userData['profileImageUrl'] ??
                'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
          );
        }
      }
    } catch (e) {
      // print('Error fetching user data: $e');
    }
    return null;
  }

  Future<List<Project>> fetchProjectsForStudent() async {
    try {
      Future<Student?> student = fetchStudentData();
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

  Future<void> createNewProject(Project project) async {
    try {
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
    } catch (e) {
      log('Error creating new project: $e');
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      final docRef = await studentCollection
          .where('email', isEqualTo: student.email)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first.reference);
      await docRef.update(student.toJson());
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> uploadProfileImage(
    Student student,
  ) async {
    try {
      final File? image = await _utils.pickImage();
      if (image != null) {
        final String imagePath = 'students/${student.studentId}/profileImage';
        final String? downloadURL =
            await _firebaseService.uploadImage(image, imagePath);

        if (downloadURL != null) {
          student.profileImageUrl = downloadURL;
          await updateStudent(student);
        } else {
          log('No image selected');
        }
      } else {
        log('No image selected');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
