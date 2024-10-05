import 'package:flutter/services.dart';

class OpenDeviceAdminSettings {
  static const platform = MethodChannel('app_spend_time_channel');

  static Future<void> requestDeviceAdmin() async {
    try {
      await platform.invokeMethod('appSpendTime');
    } on PlatformException catch (e) {
      print("Lỗi khi lấy thời gian sử dụng của app: ${e.message}");
    }
  }
}
