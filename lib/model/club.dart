import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  final String id;
  final String email;
  final String name;
  String profileImageURL;
  String? about;
  String? inCharge;
  String? president;
  String? bannerImageURL;
  List<Map<String, dynamic>>? events;

  Club({
    required this.id,
    required this.email,
    required this.name,
    required this.profileImageURL,
    this.about,
    this.inCharge,
    this.president,
    this.bannerImageURL,
    this.events,
  });

  factory Club.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;

    return Club(
      id: snapshot.id,
      email: snapshotData['email'],
      name: snapshotData['name'],
      about: snapshotData['about'],
      inCharge: snapshotData['inCharge'],
      president: snapshotData['president'],
      profileImageURL: snapshotData['profileImageURL'],
      bannerImageURL: snapshotData['bannerImageURL'],
      events: List<Map<String, dynamic>>.from(snapshotData['events'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'about': about,
        'inCharge': inCharge,
        'president': president,
        'profileImageURL': profileImageURL,
        'bannerImageURL': bannerImageURL,
        'events': events,
      };
}
