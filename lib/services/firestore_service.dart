import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Dns.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Dns>> getDnsList() {
    return _firestore.collection('dns_logs').snapshots().map((snapshots) {
      return snapshots.docs.map((doc) => Dns.fromMap(doc.data())).toList();
    });
  }

  // update to ip address
  Future<void> updateIpAddress(
      String userId, String childId, String newIpAddress) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('user').doc(userId);
    DocumentSnapshot userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      List<dynamic> childList = userSnapshot.get('childList');
      for (var child in childList) {
        if (child['idChild'] == childId) {
          child['ipAddress'] = newIpAddress;
          break;
        }
      }
      await userRef.update({'childList': childList});
    } else {
      print('Người dùng không tồn tại!');
    }
  }
}
