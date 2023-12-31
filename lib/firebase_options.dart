// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA88xfQ-uWIKWw2gCyvfn6jLI3RKaRwKH4',
    appId: '1:89946636904:web:af39a82ec79113ea3db1dd',
    messagingSenderId: '89946636904',
    projectId: 'scholarsync-5cac5',
    authDomain: 'scholarsync-5cac5.firebaseapp.com',
    storageBucket: 'scholarsync-5cac5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRepPG_Sh7VZhXcV4k-UK1H4lqjuFfsc8',
    appId: '1:89946636904:android:31edcda54dc4a9b23db1dd',
    messagingSenderId: '89946636904',
    projectId: 'scholarsync-5cac5',
    storageBucket: 'scholarsync-5cac5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHfyqSZsqA5gPJ1Y_C_gCoHO0owlwqBOM',
    appId: '1:89946636904:ios:9049fa1e505eb4ec3db1dd',
    messagingSenderId: '89946636904',
    projectId: 'scholarsync-5cac5',
    storageBucket: 'scholarsync-5cac5.appspot.com',
    iosBundleId: 'com.example.scholarsMobileapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHfyqSZsqA5gPJ1Y_C_gCoHO0owlwqBOM',
    appId: '1:89946636904:ios:4237b1b397dec1f63db1dd',
    messagingSenderId: '89946636904',
    projectId: 'scholarsync-5cac5',
    storageBucket: 'scholarsync-5cac5.appspot.com',
    iosBundleId: 'com.example.scholarsMobileapp.RunnerTests',
  );
}
