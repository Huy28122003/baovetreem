import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DefaultData {
  static late String _fcmToken;
  static late String _userid;

  static Future<void> initialize() async {
    _fcmToken = (await FirebaseMessaging.instance.getToken())!;
    FirebaseAuth.instance;
    if(FirebaseAuth.instance.currentUser !=null){
      _userid = await FirebaseAuth.instance.currentUser!.uid;
    }else{
      _userid = "";
    }
    print(_userid);
    print(_fcmToken);
  }

  static String get userid => _userid;

  static String get fcmToken => _fcmToken;
}

