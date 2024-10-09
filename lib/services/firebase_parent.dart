import 'dart:math';
import 'package:app_usage/app_usage.dart';
import 'package:bao_ve_tre_em/models/Parent.dart';
import 'package:bao_ve_tre_em/services/default_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/App.dart';
import '../models/Children.dart';

class ParentService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addParent(Parent parent) async {
    await _firestore.collection('user').doc(parent.id).set(parent.toMap());
  }

  Future<String> findUserWithCode(String code) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .where('linkCode', isEqualTo: code)
          .get();
      if (querySnapshot.docs.isEmpty) {
        print("Không có người dùng nào có mã liên kết này.");
        return "";
      } else {
        print("Mã có tồn tại trong danh sách người dùng");
        Map<String, dynamic> data =
            querySnapshot.docs[0].data() as Map<String, dynamic>;
        String email = data['email'];
        return email;
      }
    } catch (e) {
      print("Lỗi khi truy vấn Firestore: $e");
      return "";
    }
  }

  Future<String> addChildToList(String name, String fcmToken) async {
    try {
      Children newChild = Children(fcmToken, [], name, []);
      DocumentReference userRef = _firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid);
      await userRef.update({
        'childList': FieldValue.arrayUnion([newChild.toMap()])
      });
      return ""; // Thành công
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        print("Dữ liệu người dùng với ID :");
        print(documentSnapshot.data());
      } else {
        print("Không tìm thấy người dùng với ID ");
      }
    } catch (e) {
      print("Lỗi khi truy vấn Firestore: $e");
    }
  }

  Future<void> pushAppList(List<App> list) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic> childData = data['childList'];
        int index = childData
            .indexWhere((child) => child['fcmToken'] == DefaultData.fcmToken);
        print(DefaultData.fcmToken);
        if (index != -1) {
          childData[index]['appList'] = list.map((app) => app.toMap()).toList();
          ;
          _firestore
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .update({'childList': childData});
        }
      }
    } catch (e) {}
  }

  Future<List<Children>> getChild() async {
    DocumentSnapshot snapshot = await _firestore
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (snapshot.exists) {
      List<dynamic> data = snapshot['childList'];
      List<Children> childList = [];
      for (var i in data) {
        Children children = Children.fromMap(i);
        print(children);
        childList.add(children);
      }
      for (int i = 0; i < childList.length;) {
        print(childList[i].name);
      }
      return childList;
    } else {
      return [];
    }
  }

  Future<void> pushAppUsage(List<App> appUsage) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> childData = data['childList'];
    int index = childData.indexWhere(
        (child) => child['fcmToken'].toString() == DefaultData.fcmToken);
    if (index != -1) {
      List<dynamic> appList = childData[index]['appList'];
      for (var i in appUsage) {
        int id =
            appList.indexWhere((app) => app['packageName'] == i.packgeName);
        if(id!=-1){
          appList[id]['spendTime'] = i.time;
          childData[index]['appList'] = appList;
          // print("asdasdas $childData");
          _firestore
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'childList': childData});
        }
      }
    }
  }
}
