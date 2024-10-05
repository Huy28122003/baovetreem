import 'package:cloud_firestore/cloud_firestore.dart';

class Dns{
  final DateTime time;
  final String domain;

  Dns({required this.time, required this.domain});

  factory Dns.fromMap(Map<String,dynamic> map) {
    return Dns(
      time:(map['timestamp'] as Timestamp).toDate(),
      domain: map['domain'],
    );
  }
}