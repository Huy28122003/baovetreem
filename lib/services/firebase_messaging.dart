import 'package:firebase_messaging/firebase_messaging.dart';

class Messaging{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<String?> getFCMToken() async {
    String? fcmToken = await messaging.getToken();
    return fcmToken;
  }
}