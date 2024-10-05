import 'package:bao_ve_tre_em/children/child_link_code.dart';
import 'package:flutter/material.dart';

class ChildInstructions extends StatefulWidget {
  const ChildInstructions({super.key});

  @override
  State<ChildInstructions> createState() => _ChildInstructionsState();
}

class _ChildInstructionsState extends State<ChildInstructions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(0, 0, 200, 0.2),
              const Color.fromRGBO(255, 100, 100, 0.7)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            const Text(
              "Hướng dẫn liên kết thiết bị",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            Container(
              width: 350,
              height: 38,
              child: Text(
                  "Bước 1: Trên phần mềm BVTE phụ huynh, chọn thêm thiết bị"),
            ),
            Container(
              width: 350,
              height: 38,
              child: Text(
                  "Bước 2: Nhập thông tin cho thiết bị mới, sau đó chọn Tiếp tục"),
            ),
            ClipRRect(
              child: Image.asset(
                "assets/images/bvte2.png",
                width: 150,
                height: 200,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            Container(
              width: 350,
              height: 38,
              child: Text(
                  "Bước 3: Trên thiết bị của trẻ, nhập mã số gồm 6 chữ số tại mục 3"),
            ),
            ClipRRect(
              child: Image.asset(
                "assets/images/bvte3.png",
                width: 150,
                height: 200,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(colors: [Colors.blue, Colors.purple])
                          .createShader(bounds),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChildLinkCode()),
                        );
                      },
                      child: const Text(
                        "Đã hiểu",
                      ))),
            )
          ],
        ),
      ),
    ));
  }
}
