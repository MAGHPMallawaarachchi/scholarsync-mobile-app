import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String email;
  final String studentId;
  final String firstName;
  final String lastName;
  final String degreeProgram;
  final String batch;
  List<Map<String, dynamic>>? projects;

  Student({
    required this.email,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.degreeProgram,
    required this.batch,
    this.projects,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'degreeProgram': degreeProgram,
      'batch': batch,
      'projects': projects,
    };
  }

  factory Student.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    return Student(
      email: snapshotData['email'],
      studentId: snapshotData['studentId'],
      firstName: snapshotData['firstName'],
      lastName: snapshotData['lastName'],
      degreeProgram: snapshotData['degreeProgram'],
      batch: snapshotData['batch'],
      projects: snapshotData['projects'],
    );
  }
}
