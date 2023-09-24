import 'dart:async';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarsync/themes/palette.dart';

class LectureService {
  Future<List<CalendarEventData>> getAllLectures() async {
    List<CalendarEventData> lectures = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('lectures').get();

      for (var doc in querySnapshot.docs) {
        CalendarEventData lecture = CalendarEventData(
          date: doc['date'].toDate(),
          title: doc['title'],
          description: doc['description'],
          startTime: doc['startTime'].toDate(),
          endTime: doc['endTime'].toDate(),
          color: CommonColors.primaryGreenColor,
        );

        lectures.add(lecture);
      }
    } catch (e) {
      log('Error fetching data from Firestore: $e');
    }

    return lectures;
  }
}
