import 'package:bao_ve_tre_em/children/child_instructions.dart';
import 'package:bao_ve_tre_em/children/prepare_permission.dart';
import 'package:bao_ve_tre_em/parent/sign_in.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SignIn()));
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/signIn',
                (Route<dynamic> route) => false,
              );
            },
            child: const Text("Parent")),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildInstructions()));
        }, child: Text("Child"))
      ],
    )));
  }
}
