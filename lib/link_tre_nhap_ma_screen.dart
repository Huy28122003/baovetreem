import 'package:bao_ve_tre_em/link_tre_huong_dan_screen.dart';
import 'package:bao_ve_tre_em/link_tre_xac_nhan_screen.dart';
import 'package:flutter/material.dart';

class LinkNhapMaScreen extends StatefulWidget {
  const LinkNhapMaScreen({super.key});

  @override
  State<LinkNhapMaScreen> createState() => _LinkNhapMaScreenState();
}

class _LinkNhapMaScreenState extends State<LinkNhapMaScreen> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 350,
                height: 60,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vui lòng nhập mã liên kết từ ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "BVTE dành cho Phụ huynh",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                for (int i = 0; i < 6; i++)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LinkHuongDan()));
                },
                child: const Text(
                  "Làm thế nào để có liên kết?",
                  style: TextStyle(color: Colors.blue),
                )),
            const SizedBox(height: 50,),
            SizedBox(
              width: 150,
              height: 40,
              child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(colors: [Colors.blue, Colors.purple])
                          .createShader(bounds),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_){
                          return const LinkXacNhan(email: "nguyenvana@gmail.com");
                        });
                      },
                      child: const Text(
                        "Tiếp tục",
                      ))),
            )
          ],
        ),
      ),
    ));
  }
}
