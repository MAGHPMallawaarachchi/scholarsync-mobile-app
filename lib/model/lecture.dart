import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  final String title;
  final String description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String id;

  Lecture({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  factory Lecture.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Lecture(
      date: data['date'].toDate(),
      startTime: data['startTime'].toDate(),
      endTime: data['endTime'].toDate(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
    );
  }
}
