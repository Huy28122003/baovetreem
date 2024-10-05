import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:bao_ve_tre_em/children/app_list.dart';
import 'package:bao_ve_tre_em/children/app_using_time.dart';
import 'package:bao_ve_tre_em/children/child_push_data.dart';
import 'package:bao_ve_tre_em/children/child_set_profile.dart';
import 'package:bao_ve_tre_em/child/link_tre_chi_tiet_screen.dart';
import 'package:bao_ve_tre_em/services/device_admin_channel.dart';
import 'package:flutter/material.dart';

class ChildPermissionGrant extends StatefulWidget {
  bool deviceAdminEnaled;
  bool accessibilityServiceEnabled;
  bool usageStatsEnabled;

  ChildPermissionGrant(
      {required this.deviceAdminEnaled,
      required this.accessibilityServiceEnabled,
      required this.usageStatsEnabled});

  @override
  State<ChildPermissionGrant> createState() => _ChildPermissionGrantState();
}

class _ChildPermissionGrantState extends State<ChildPermissionGrant> {
  late bool _deviceAdminEnaled;
  late bool _accessibilityServiceEnabled;
  late bool _usageStatsEnabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deviceAdminEnaled = widget.deviceAdminEnaled;
    _accessibilityServiceEnabled = widget.accessibilityServiceEnabled;
    _usageStatsEnabled = widget.usageStatsEnabled;
  }

  void openAppUsageSetting() {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.settings.USAGE_ACCESS_SETTINGS',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  void openAccessibilitySetting() {
    final AndroidIntent intent =
        AndroidIntent(action: 'android.settings.ACCESSIBILITY_SETTINGS');
    intent.launch();
  }

  void openDeviceAdminSettings() {
    DeviceAdminPermission.requestDeviceAdmin();
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
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/bvte6.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                  width: 330,
                  child: Text(
                      "Để kích hoạt các tính năng của BVTE hoạt động đúng, vui lòng cấp tất cả các quyền cần thiết.")),
              Transform.scale(
                  scale: 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _usageStatsEnabled,
                        onChanged: !_usageStatsEnabled
                            ? (value) async {
                                openAppUsageSetting();
                                if (await DeviceAdminPermission
                                    .checkUsageStatsPermission()) {
                                  setState(() {
                                    _usageStatsEnabled = true;
                                  });
                                }
                              }
                            : null,
                        title: const Text("Quyền truy cập",
                            style: TextStyle(fontSize: 14)),
                        subtitle: const Text(
                          "Hạn chế thời gian sử dụng màn hình và ứng dụng cho thiết bị này.",
                          style: TextStyle(fontSize: 12),
                        ),
                        secondary: const Icon(Icons.lock),
                      ),
                    ),
                  )),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _deviceAdminEnaled,
                      onChanged: !_deviceAdminEnaled
                          ? (value) async {
                              openDeviceAdminSettings();
                              if (await DeviceAdminPermission
                                  .checkDeviceAdminPermission()) {
                                setState(() {
                                  _deviceAdminEnaled = true;
                                });
                              }
                            }
                          : null,
                      title: const Text("Quyền quản trị thiết bị",
                          style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Quyền quản trị viên ở cấp độ hệ thống ",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _accessibilityServiceEnabled,
                      onChanged: !_accessibilityServiceEnabled
                          ? (value) async {
                              openAccessibilitySetting();
                              if (await DeviceAdminPermission
                                  .checkAccessibilityServicePermission()) {
                                setState(() {
                                  _accessibilityServiceEnabled = true;
                                });
                              }
                            }
                          : null,
                      title: const Text("Quyền giám sát hành vi",
                          style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Theo dõi các hành động thực hiện trên thiết bị này",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (value) {},
                      title: const Text("Quyền quản trị thiết bị",
                          style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Đảm bảo hoạt động ổn định của BVTE trong nền và giảm khả năng bị gỡ ứng dụng.",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.purple])
                        .createShader(bounds),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       InstalledAppsScreen()));
                        },
                        child: const Text(
                          "Xác nhận",
                        ))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
