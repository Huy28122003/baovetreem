import 'package:bao_ve_tre_em/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lấy địa chỉ IP VPN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IPAddressScreen(),
    );
  }
}

class IPAddressScreen extends StatefulWidget {
  @override
  _IPAddressScreenState createState() => _IPAddressScreenState();
}

class _IPAddressScreenState extends State<IPAddressScreen> {
  FirestoreService _firestoreService = FirestoreService();
  static Future<String?> getLocalIpAddress() async {
    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4, includeLinkLocal: true);

    try {
      // Try VPN connection first
      NetworkInterface vpnInterface = interfaces.firstWhere((element) => element.name == "tun0");
      return vpnInterface.addresses.first.address;
    } on StateError {
      // Try wlan connection next
      try {
        NetworkInterface interface = interfaces.firstWhere((element) => element.name == "wlan0");
        return interface.addresses.first.address;
      } catch (ex) {
        // Try any other connection next
        try {
          NetworkInterface interface = interfaces.firstWhere((element) => !(element.name == "tun0" || element.name == "wlan0"));
          return interface.addresses.first.address;
        } catch (ex) {
          return null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ IP VPN'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: getLocalIpAddress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            // Hiển thị địa chỉ IP hoặc thông báo lỗi
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi, size: 50, color: Colors.green),
                  SizedBox(height: 20),
                  const Text(
                    'Địa chỉ IP của thiết bị:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!, // Hiển thị địa chỉ IP
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return Text(
                'Không tìm thấy địa chỉ IP',
                style: TextStyle(fontSize: 18),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Gọi lại FutureBuilder để lấy địa chỉ IP mới
            _firestoreService.updateIpAddress('09kD5x9mYmCGVnyJ5qxh', '01','10.8.0.2');
          });
        },
        tooltip: 'Lấy địa chỉ IP',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}


