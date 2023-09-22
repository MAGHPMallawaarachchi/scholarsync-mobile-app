import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  String id;
  DateTime startTime;
  DateTime endTime;
  String batch;
  String degreeProgram;
  String lectureHall;
  String moduleCode;
  String lecturer;

  Lecture({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.batch,
    required this.degreeProgram,
    required this.lectureHall,
    required this.moduleCode,
    required this.lecturer,
  });

  factory Lecture.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;

    return Lecture(
      id: snapshot.id,
      startTime: (snapshotData['startTime'] as Timestamp).toDate(),
      endTime: (snapshotData['endTime'] as Timestamp).toDate(),
      batch: snapshotData['batch'] as String,
      degreeProgram: snapshotData['degreeProgram'] as String,
      lectureHall: snapshotData['lectureHall'] as String,
      moduleCode: snapshotData['moduleCode'] as String,
      lecturer: snapshotData['lecturer'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime,
        'endTime': endTime,
        'batch': batch,
        'degreeProgram': degreeProgram,
        'lectureHall': lectureHall,
        'moduleCode': moduleCode,
        'lecturer': lecturer,
      };
}
