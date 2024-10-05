import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class StartVpnScreen extends StatefulWidget {
  const StartVpnScreen({super.key});

  @override
  State<StartVpnScreen> createState() => _StartVpnScreenState();
}

class _StartVpnScreenState extends State<StartVpnScreen> {
  final OpenVPN _openVPN = OpenVPN();
  @override
  void initState() {
    super.initState();
    _openVPN.initialize(
      groupIdentifier: "group.com.example.bao_ve_tre_em",
      providerBundleIdentifier: "com.example.bao_ve_tre_em.",
    );
  }

  Future<String> _loadConfig() async {
    return await rootBundle.loadString('assets/vpnConfig/client1.ovpn');
  }

  void _connectVPN() async {
    try {
      String config = await _loadConfig();
      await _openVPN.connect(config, "OpenVPN");
      print('Connected to VPN');
    } catch (e) {
      print('Error connecting to VPN: $e');
    }
  }
  static const platform = MethodChannel('vpn');
  Future<void> _startVpn() async {
    try {
      final String result = await platform.invokeMethod('startVpn');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to start VPN: '${e.message}'.");
    }
  }

  Future<void> _stopVpn() async {
    try {
      final String result = await platform.invokeMethod('stopVpn');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to stop VPN: '${e.message}'.");
    }
  }
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child:Switch(value: _value, onChanged: (newValue){
          setState(() {
            _value = newValue;
            if(_value){
              // _startVpn();
              _connectVPN();
            }
            else{
              // _stopVpn();
              _openVPN.disconnect();
            }
          });
        }),),
    ));
  }
}

// 5x5z9nc sbaK419KNqEK
