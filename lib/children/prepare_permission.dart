import 'package:app_usage/app_usage.dart';
import 'package:bao_ve_tre_em/children/child_grant_permission.dart';
import 'package:bao_ve_tre_em/services/device_admin_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:permission_handler/permission_handler.dart';

class PreparePermission extends StatefulWidget {
  const PreparePermission({super.key});

  @override
  State<PreparePermission> createState() => _PreparePermissionState();
}

class _PreparePermissionState extends State<PreparePermission> {
  bool _accessibilityEnabled = false;
  bool _usageStatsEnabled = false;
  bool _deviceAdminEnabled = false;
  double _progress = 0;

  Future<void> _checkPermissions() async {
    _accessibilityEnabled =
        await DeviceAdminPermission.checkAccessibilityServicePermission();
    if(_accessibilityEnabled){
      _updateProgress();
    }
    _usageStatsEnabled =
        await DeviceAdminPermission.checkUsageStatsPermission();
    if(_usageStatsEnabled){
      _updateProgress();
    }
    _deviceAdminEnabled =
        await DeviceAdminPermission.checkDeviceAdminPermission();
    if(_deviceAdminEnabled){
      _updateProgress();
    }

    print(_accessibilityEnabled);
    print(_usageStatsEnabled);
    print(_deviceAdminEnabled);
    print(_progress);

  }

  void _updateProgress() {
    setState(() {
      _progress += 1 / 3;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // requestPermissions();
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 200, 0.2),
              Color.fromRGBO(255, 100, 100, 0.7)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              ClipRRect(
                child: Image.asset(
                  "assets/images/bvte5.png",
                  width: 200,
                  height: 200,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  width: 300,
                  child: Text(
                      "Đang kiểm tra các quyền cần thiết, vui lòng chờ cho đến khi quá trình hoàn tất")),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 284,
                height: 10,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(100),
                  value: _progress ,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildPermissionGrant(
                                  deviceAdminEnaled: _deviceAdminEnabled,
                                  accessibilityServiceEnabled:
                                      _accessibilityEnabled,
                                  usageStatsEnabled: _usageStatsEnabled,
                                )));
                  },
                  child: const Text("Tiếp tục"))
            ],
          ),
        ),
      ),
    ));
  }

}
