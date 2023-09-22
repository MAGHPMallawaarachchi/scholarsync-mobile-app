import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarsync/model/lectures.dart';

class LecturesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Lecture>> streamLectures() {
    return _firestore.collection('lectures').snapshots().map((snapshot) {
      final List<Lecture> lectures = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Create an Lecture object for each lecture and add it to the list
        final Lecture lecture = Lecture(
          id: doc.id,
          startTime: (data['startTime'] as Timestamp).toDate(),
          endTime: (data['endTime'] as Timestamp).toDate(),
          batch: data['batch'] as String,
          degreeProgram: data['degreeProgram'] as String,
          lectureHall: data['lectureHall'] as String,
          moduleCode: data['moduleCode'] as String,
          lecturer: data['lecturer'] as String,
        );

        lectures.add(lecture);
      }

      return lectures;
    }).handleError((error) {
      print('Error fetching lectures: $error');
      return [];
    });
  }
}
