import 'package:bao_ve_tre_em/children/child_set_profile.dart';
import 'package:bao_ve_tre_em/children/prepare_permission.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';

class ChildConfirm extends StatelessWidget {
  String email;

  ChildConfirm({super.key, required this.email});

  ParentService _parentService = ParentService();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // decoration: BoxDecoration(color: Colors.white),
        width: 350,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              child: Image.asset(
                "assets/images/bvte4.png",
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            const Text(
              "Xác nhận liên kết",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "Thiết bị của bạn sẽ được liên kết với:",
            ),
            Text(email, style: const TextStyle(color: Colors.blue)),
            SizedBox(
              width: 150,
              height: 40,
              child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(colors: [Colors.blue, Colors.purple])
                          .createShader(bounds),
                  child: ElevatedButton(
                      onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChildSetProfile()));
                      },
                      child: const Text(
                        "Xác nhận",
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
