import 'package:flutter/services.dart';

class DeviceAdminPermission {
  static const platform = MethodChannel('OpenDeviceAdminSetting');

  static Future<void> requestDeviceAdmin() async {
    try {
      await platform.invokeMethod('requestDeviceAdmin');
    } on PlatformException catch (e) {
      print("Lỗi khi yêu cầu quyền Device Admin: ${e.message}");
    }
  }

  static Future<bool> checkDeviceAdminPermission() async {
    try {
      // Gọi phương thức Java và nhận giá trị boolean
      final bool isEnabled = await platform.invokeMethod('checkDeviceAdminStatus');
      return isEnabled;
    } on PlatformException catch (e) {
      print("Failed to check Device Admin permission: ${e.message}");
      return false; // Trả về false nếu có lỗi
    }
  }

  static Future<bool> checkUsageStatsPermission() async {
    try {
      // Gọi phương thức Java và nhận giá trị boolean
      final bool isEnabled = await platform.invokeMethod('checkUsageStatsPermission');
      return isEnabled;
    } on PlatformException catch (e) {
      print("Failed to check  Usage Stats permission: ${e.message}");
      return false; // Trả về false nếu có lỗi
    }
  }
  static Future<bool> checkAccessibilityServicePermission() async {
    try {
      // Gọi phương thức Java và nhận giá trị boolean
      final bool isEnabled = await platform.invokeMethod('checkAccessibilityServicePermission');
      return isEnabled;
    } on PlatformException catch (e) {
      print("Failed to check  Usage Stats permission: ${e.message}");
      return false; // Trả về false nếu có lỗi
    }
  }
}
