
import 'dart:math';
import 'package:bao_ve_tre_em/models/App.dart';
import 'package:bao_ve_tre_em/models/Children.dart';
import 'package:bao_ve_tre_em/models/Parent.dart';
import 'package:bao_ve_tre_em/services/firebase_authentication.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passs = TextEditingController();
  UserAuthentication _auth = UserAuthentication();
  ParentService _parentService = ParentService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Đăng kí tài khoản"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
          ),TextField(
            controller: _pass,
            obscureText: true,
          ),TextField(
            controller: _passs,
            obscureText: true,
          ),
          ElevatedButton(onPressed: (){
            signUp();
          }, child: Text("Xác nhận"))
        ],
      ),
    ));
  }

  void signUp()async{
    String email = _email.text;
    String pass = _pass.text;
    String passs = _passs.text;
    if(pass!=passs){
      print("Không khớp");
    }else{
      User? user = await _auth.signUp(context, email, pass);

      if(user!=null){
        int linkCode = Random().nextInt(9000) + 1000;
        List<App> appL = [App("first", false, "0","")];
        List<Children> list = [Children("00",appL,"",[])];
        _parentService.addParent(Parent(user!.uid, list, "${linkCode}",email));
        _showConfirmationDialog("${linkCode}");
      }
    }

  }

  void _showConfirmationDialog(String linkCode) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Mã liên kết với thiết bị của trẻ"),
          content:  Text(linkCode),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/dashBoard',
                      (Route<dynamic> route) => false,
                );
              },
              child: const Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }
}
