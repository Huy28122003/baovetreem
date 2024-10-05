import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import '../models/App.dart';

class InstalledAppsScreen extends StatefulWidget {
  @override
  _InstalledAppsScreenState createState() => _InstalledAppsScreenState();
}

class _InstalledAppsScreenState extends State<InstalledAppsScreen> {
  List<Application>? _installedApps;
  ParentService _parentService = ParentService();

  @override
  void initState() {
    super.initState();
    _getInstalledApps();
  }

  Future<void> _getInstalledApps() async {
    List<String> keepSystemApps = [
      'com.facebook.katana', // Facebook
      'com.google.android.youtube', // YouTube
      'com.skype.raider',
      'com.android.providers.telephony',
      'com.google.android.googlequicksearchbox',
      ' com.samsung.android.calendar',
      'com.zing.zalo',
      'org.telegram.messenge',
      'com.sec.android.mimage.gear360editor',
      'com.samsung.android.incallui',
      'com.android.documentsui',
      'com.android.providers.downloads',
      'com.wsomacp',
      'com.sec.android.app.voicenote',
      ' com.samsung.android.email.provider',
      'com.microsoft.office.excel',
      ' com.sec.android.app.samsungapps',
      'com.android.providers.downloads.ui',
      'com.microsoft.skydrive',
      'com.samsung.android.video',
      'com.android.providers.contacts',
      'com.android.bluetooth',
      'com.sec.android.app.camera',
      'com.android.phone',
      'com.samsung.android.app.bikemode',
      'com.samsung.android.app.notes',
      'com.android.settings',
      'com.sec.android.app.popupcalculator',
      ''
          'com.facebook.orca',
      'com.google.android.apps.photos',
      'com.sec.android.app.myfiles',
      'com.google.android.videos',
      'com.android.server.telecom',
      'com.microsoft.office.powerpoint',
      'com.sec.android.app.clockpackage',
      'com.microsoft.office.word',
      'com.google.android.apps.maps',
      'com.google.android.apps.docs',
      'com.google.android.music',
      'com.sec.android.gallery3d',
      'com.google.android.gm',
      'com.microsoft.office.onenote',
      'com.samsung.android.messaging',
      'com.android.vending'
    ];
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true, // Vẫn lấy tất cả ứng dụng
      includeAppIcons: true, // Bao   gồm icon của ứng dụng
    );

    // Loại bỏ các ứng dụng hệ thống
    // List<Application> userInstalledApps = apps.where((app) => !(app as Application).systemApp).toList();

    setState(() {
      _installedApps = apps;
    });
    List<App> list = [];
    for (var i in apps) {
      if (i.systemApp && !keepSystemApps.contains(i.packageName)) {
        continue;
      }
      App app = App(i.packageName, false, "0", i.appName);
      list.add(app);
    }
    _parentService.pushData(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách ứng dụng đã cài"),
      ),
      body: _installedApps == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _installedApps!.length,
              itemBuilder: (context, index) {
                Application app = _installedApps![index];
                return ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(app.icon) // Hiển thị icon của ứng dụng
                      : null,
                  title: Text(app.appName),
                  subtitle: Text(app.packageName),
                );
              },
            ),
    );
  }
}
