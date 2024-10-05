import 'package:bao_ve_tre_em/parent/dash_board.dart';
import 'package:bao_ve_tre_em/parent/sign_up.dart';
import 'package:bao_ve_tre_em/services/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  UserAuthentication _auth = UserAuthentication();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Sign in")),
      body: Column(
        children: [
          TextField(
            controller: _email,
          ),
          TextField(
            controller: _pass,
          ),
          Row(
            children: [
              Text("Bạn chưa có tài khoản?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("Đăng kí")),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: const Text("Xác nhận"))
        ],
      ),
    ));
  }

  Future<void> signIn() async {
    String email = _email.text;
    String pass = _pass.text;
    User? user = await _auth.signIn(context, email, pass);
    if (user != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashBoard',
        (Route<dynamic> route) => false,
      );
    }
  }
}
