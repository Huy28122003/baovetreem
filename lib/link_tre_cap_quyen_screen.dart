import 'package:bao_ve_tre_em/link_tre_cap_quyen2_screen.dart';
import 'package:flutter/material.dart';

class LinkCapQuyenScreen extends StatefulWidget {
  const LinkCapQuyenScreen({super.key});

  @override
  State<LinkCapQuyenScreen> createState() => _LinkCapQuyenScreenState();
}

class _LinkCapQuyenScreenState extends State<LinkCapQuyenScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        child: Container(
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
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                ClipRRect(
                  child: Image.asset(
                    "assets/images/bvte5.png",
                    width: 200,
                    height: 200,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: 300,
                    child: Text(
                        "Đang kiểm tra các quyền cần thiết, vui lòng chờ cho đến khi quá trình hoàn tất")),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 284,
                  height: 10,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LinkCapQuyen2Screen()));
        },
      )
    ));
  }
}
