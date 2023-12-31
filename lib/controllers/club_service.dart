import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scholarsync/controllers/firebase_service.dart';
import '../model/club.dart';
import '../utils/utils.dart';

class ClubService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  final FirebaseService _firebaseService = FirebaseService();
  final Utils _utils = Utils();

  final StreamController<List<String>> _eventImageUrlsController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get eventImageUrlsStream =>
      _eventImageUrlsController.stream;

  void listenForClubUpdates() {
    FirebaseFirestore.instance
        .collection('clubs')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      final updatedImageUrls = getEventImageURLs(snapshot);
      _eventImageUrlsController.add(updatedImageUrls);
    });
  }

  Stream<List<Club>> getAllClubs() {
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
          _firestore.collection('clubs').snapshots();
      return querySnapshot.map((snapshot) =>
          snapshot.docs.map((doc) => Club.fromSnapshot(doc)).toList());
    } catch (error) {
      log(error.toString());
      return Stream.value([]);
    }
  }

  Future<Club?> getClubByEmail(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('clubs')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs[0].data();

        return Club(
          id: querySnapshot.docs[0].id,
          email: userData['email'],
          profileImageURL: userData['profileImageURL'],
          name: userData['name'] ?? 'Club Name',
          about: userData['about'] ?? 'About',
          inCharge: userData['inCharge'] ?? 'In Charge',
          president: userData['president'] ?? 'President',
          bannerImageURL: userData['bannerImageURL'] ??
              'https://w7.pngwing.com/pngs/869/370/png-transparent-low-polygon-background-green-banner-low-poly-materialized-flat-thumbnail.png',
          events: List<Map<String, dynamic>>.from(userData['events'] ?? []),
        );
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
    return null;
  }

  Stream<Map<String, List<dynamic>>> getClubEvents(String email) {
    try {
      final Stream<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
          _firestore.collection('clubs').doc(email).snapshots();
      return documentSnapshot.map((snapshot) => snapshot.data()!['events']);
    } catch (error) {
      log(error.toString());
      return Stream.value({});
    }
  }

  Stream<List<Map<String, String>>> streamProfileImageURLs() {
    return _firestore.collection('clubs').snapshots().map((snapshot) {
      final List<Map<String, String>> imageUrlsWithEmail = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('profileImageURL') &&
            data['profileImageURL'] is String) {
          final String imageUrl = data['profileImageURL'];

          if (imageUrl.isNotEmpty) {
            final String email = data['email'] ?? '';

            final Map<String, String> imageInfo = {
              'email': email,
              'imageUrl': imageUrl,
            };

            imageUrlsWithEmail.add(imageInfo);
          }
        }
      }

      log('Image URLs with email: $imageUrlsWithEmail');
      return imageUrlsWithEmail;
    }).handleError((error) {
      log('Error fetching image URLs: $error');
      return [];
    });
  }

  Future<void> addClub(Club club) async {
    try {
      await _firestore.collection('clubs').doc(club.email).set(club.toJson());
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> updateClub(Club club) async {
    try {
      final docRef = await _firestore
          .collection('clubs')
          .where('email', isEqualTo: club.email)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first.reference);
      await docRef.update(club.toJson());
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> deleteClub(Club club) async {
    try {
      await _firestore.collection('clubs').doc(club.email).delete();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> uploadImageAndUpdateClub(
    String imageUrlField,
    Club club,
  ) async {
    try {
      final File? image = await _utils.pickImage();
      if (image != null) {
        if (imageUrlField == 'profileImageURL') {
          final String imagePath = 'clubs/${club.name}/profileImage';
          final String? downloadURL =
              await _firebaseService.uploadImage(image, imagePath);

          if (downloadURL != null) {
            club.profileImageURL = downloadURL;
            await updateClub(club);
          } else {
            log('No image selected');
          }
        } else if (imageUrlField == 'bannerImageURL') {
          final String imagePath = 'clubs/${club.name}/bannerImage';
          final String? downloadURL =
              await _firebaseService.uploadImage(image, imagePath);

          if (downloadURL != null) {
            club.bannerImageURL = downloadURL;
            await updateClub(club);
          } else {
            log('No image selected');
          }
        }
      } else {
        log('No image selected');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadEvent(String email) async {
    final Club? club = await getClubByEmail(email);
    try {
      if (club != null) {
        final eventImage = await _utils.pickImage();
        String imageName = eventImage!.path.split('/').last;
        final storagePath = 'clubs/${club.name}/events/$imageName';
        String? eventImageURL =
            await _firebaseService.uploadImage(eventImage, storagePath);

        // Create a new event map
        Map<String, dynamic> eventData = {
          'imageUrl': eventImageURL,
          'approved': false,
        };
        club.events ??= [];
        club.events!.add(eventData);
        await updateClub(club);
      }
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> deleteEvent(int eventIndex, String email) async {
    final Club? club = await getClubByEmail(email);
    try {
      if (club != null) {
        if (club.events != null &&
            eventIndex >= 0 &&
            eventIndex < club.events!.length) {
          Map<String, dynamic> eventData = club.events![eventIndex];

          final imageUrl = eventData['imageUrl'];
          final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
          await storageRef.delete();

          club.events!.removeAt(eventIndex);

          await updateClub(club);
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  List<String> getEventImageURLs(QuerySnapshot snapshot) {
    final List<String> eventImageURLs = [];

    try {
      for (QueryDocumentSnapshot clubDocument in snapshot.docs) {
        final dynamic data = clubDocument.data();
        if (data != null) {
          final List<dynamic>? events = data['events'];

          if (events != null) {
            for (dynamic event in events) {
              if (event is Map<String, dynamic>) {
                final bool? approved = event['approved'];
                final String? imageURL = event['imageUrl'];
                if (approved == true && imageURL != null) {
                  eventImageURLs.add(imageURL);
                }
              }
            }
          }
        }
      }
    } catch (error) {
      log('Error fetching event image URLs: $error');
    }

    return eventImageURLs;
  }

  Future<List<String>> getAllClubNames() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('clubs').get();

      List<String> clubNames = [];

      for (var doc in querySnapshot.docs) {
        String name = doc.get('name');
        clubNames.add(name);
      }

      return clubNames;
    } catch (error) {
      log(error.toString());
      return [];
    }
  }

  Future<List<Map<String, String>>> getAllClubsInfo() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('clubs').get();

      List<Map<String, String>> clubInfoList = [];

      for (var doc in querySnapshot.docs) {
        String name = doc.get('name');
        String profileImageURL = doc.get('profileImageURL');
        String email = doc.get('email');

        Map<String, String> clubInfo = {
          'name': name,
          'profileImageURL': profileImageURL,
          'email': email,
        };

        clubInfoList.add(clubInfo);
      }

      return clubInfoList;
    } catch (error) {
      log(error.toString());
      return [];
    }
  }
}
