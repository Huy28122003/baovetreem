import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(BuildContext context, String email, String pass) async {
    try {
      UserCredential credential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-credential"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
          ),
        );
      }
      else{
        print("Error $e");
      }
    }
  }

  Future<User?> signUp( BuildContext context,String email,String pass) async{
    try {
      UserCredential credential =
          await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-credential"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
          ),
        );
      }
      else{
        print("Error $e");
      }
    }
  }
}
