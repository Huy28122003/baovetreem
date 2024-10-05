import 'dart:ffi';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:app_usage/app_usage.dart';
import 'package:bao_ve_tre_em/models/App.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';

class AppUsingTime extends StatefulWidget {
  const AppUsingTime({super.key});

  @override
  State<AppUsingTime> createState() => _AppUsingTimeState();
}

class _AppUsingTimeState extends State<AppUsingTime> {
  List<AppUsageInfo> _infos = [];
  ParentService _parentService = ParentService();

  @override
  void initState() {
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate =
          DateTime(endDate.year, endDate.month, endDate.day, 00, 00, 00);
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      setState(() => _infos = infoList);

      for (var info in infoList) {
        print("${info.toString()} ooooooooooo");
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_infos[index].appName),
                  trailing: Text(_infos[index].usage.toString()));
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: getUsageStats, child: Icon(Icons.file_download)),
      ),
    );
  }
}
