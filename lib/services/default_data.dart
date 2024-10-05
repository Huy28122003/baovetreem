import 'package:firebase_messaging/firebase_messaging.dart';

class DefaultData {
  static late String _fcmToken;

  static Future<void> initialize() async {
    _fcmToken = (await FirebaseMessaging.instance.getToken())!;
  }

  static String get fcmToken => _fcmToken;
}

