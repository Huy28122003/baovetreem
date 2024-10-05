import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ChildPushData extends StatefulWidget {
  const ChildPushData({super.key});

  @override
  State<ChildPushData> createState() => _ChildPushDataState();
}

class _ChildPushDataState extends State<ChildPushData> {
  List<Application>? _installedApps;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInstalledApps();
  }

  Future<void> _getInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true, // Vẫn lấy tất cả ứng dụng
      includeAppIcons: true, // Bao   gồm icon của ứng dụng
    );

    // // Loại bỏ các ứng dụng hệ thống
    // List<Application> userInstalledApps = apps.where((app) => !(app as Application).systemApp).toList();

    setState(() {
      _installedApps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Lấy danh sách ứng dụng'),
          ),
          body: _installedApps == null
              ? Center(child: CircularProgressIndicator())
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
        ));
  }
}
