import 'package:bao_ve_tre_em/services/firestore_service.dart';
import 'package:flutter/material.dart';

class PhuHuynhLayDataScreen extends StatefulWidget {
  const PhuHuynhLayDataScreen({super.key});

  @override
  State<PhuHuynhLayDataScreen> createState() => _PhuHuynhLayDataScreenState();
}

class _PhuHuynhLayDataScreenState extends State<PhuHuynhLayDataScreen> {
  final _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: _firestore.getDnsList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dns = snapshot.data!;
                    return ListView.builder(
                        itemCount: dns.length,
                        itemBuilder: (context, index) {
                          final dnsItem = dns[index];
                          return Text("${dnsItem.time} - ${dnsItem.domain}");
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
