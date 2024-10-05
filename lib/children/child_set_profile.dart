import 'package:bao_ve_tre_em/children/app_list.dart';
import 'package:bao_ve_tre_em/children/child_push_data.dart';
import 'package:bao_ve_tre_em/children/prepare_permission.dart';
import 'package:bao_ve_tre_em/services/firebase_messaging.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';

class ChildSetProfile extends StatefulWidget {
  const ChildSetProfile({super.key});

  @override
  State<ChildSetProfile> createState() => _ChildSetProfileState();
}

class _ChildSetProfileState extends State<ChildSetProfile> {

  TextEditingController _name = TextEditingController();
  ParentService _parentService = ParentService();
  Messaging _messaging = Messaging();
  late String? fcm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Profile")
      ),
      body: Column(
        children: [
          TextField(
            controller: _name,
          ),
          ElevatedButton(onPressed: () async {
            // fcm =await  _messaging.getFCMToken();
            // String name = _name.text;
            // _parentService.addChildToList(name,fcm!);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreparePermission ()));
          }, child: Text("Hoàn tất"))
        ],
      ),
    ));
  }
}
