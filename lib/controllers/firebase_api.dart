// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:scholarsync/main.dart';



// class FirebaseApi{
//   final _firebaseMessaging = FirebaseMessaging.instance;
  
//   Future<void> initNotifications() async{
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     // ignore: avoid_print
//     print('Token: $fCMToken' );
//     initPushNotifications();
//   }
  
//   void handleMessage(RemoteMessage? message){
//     if (message == null) return;
//     navigatorKey.currentState?.pushNamed(
//       '/notification',
//       arguments: message,
//     );
//   }

//   Future initPushNotifications() async{
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }