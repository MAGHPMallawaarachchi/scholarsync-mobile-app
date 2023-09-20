import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String email;
  final String studentId;
  final String firstName;
  final String lastName;
  final String degreeProgram;
  final String batch;

  Student({
    required this.id,
    required this.email,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.degreeProgram,
    required this.batch,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'degreeProgram': degreeProgram,
      'batch': batch,
    };
  }

  factory Student.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    return Student(
      id: snapshot.id,
      email: snapshotData['email'],
      studentId: snapshotData['studentId'],
      firstName: snapshotData['firstName'],
      lastName: snapshotData['lastName'],
      degreeProgram: snapshotData['degreeProgram'],
      batch: snapshotData['batch'],
    );
  }
}
