import 'package:cloud_firestore/cloud_firestore.dart';

class Lecturer {
  final String id;
  final String department;
  final String faculty;
  final String phone;
  final String name;
  final String email;
  final String profileImageURL;

  Lecturer({
    required this.id,
    required this.department,
    required this.faculty,
    required this.phone,
    required this.name,
    required this.email,
    required this.profileImageURL,
  });

  factory Lecturer.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;

    return Lecturer(
      id: snapshot.id,
      department: snapshotData['department'] ?? '',
      faculty: snapshotData['faculty'] ?? '',
      phone: snapshotData['phone'] ?? '',
      name: snapshotData['name'] ?? '',
      email: snapshotData['email'] ?? '',
      profileImageURL: snapshotData['profileImageURL'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department': department,
      'faculty': faculty,
      'phone': phone,
      'name': name,
      'email': email,
      'profileImageURL': profileImageURL,
    };
  }
}
