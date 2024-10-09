
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(0, 0, 200, 0.2),
              const Color.fromRGBO(255, 100, 50, 0.7)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/bvte1.png",
                  width: size.height / 3,
                  height: size.height / 3,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 293,
              height: 86,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Chào mừng đến",
                    style: TextStyle(
                        fontFamily: "Roboto", fontSize: 30, color: Colors.blue),
                  ),
                  Text(
                    " với BVTE",
                    style: TextStyle(
                        fontFamily: "Roboto", fontSize: 30, color: Colors.blue),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text.rich(TextSpan(children: [
                const TextSpan(
                    text: "Bạn xác nhận là người giám hộ hoặc đại diện hợp"
                        " pháp của thiết bị đã cài đặt ứng dụng cho trẻ và đồng ý "
                        "cũng như ủy quyền cho chúng tôi thu thập dữ liệu và thông "
                        "tin từ thiết bị của trẻ. Trước khi bạn tiếp tục sử dụng "
                        "dịch vụ của chúng tôi, bạn đã đọc và hiểu đầy đủ các "),
                TextSpan(
                    text: "Điều khoản Dịch vụ và Chính sách Bảo mật ",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
                const TextSpan(
                    text: " của chúng tôi. Bạn cam kết tuân thủ một cách rõ"
                        " ràng các luật lệ và quy định có hiệu lực trong vùng lãnh "
                        "thổ của bạn khi sử dụng ứng dụng")
              ])),
            ),
            Container(
              width: 150,
              height: 40,
              child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(colors: [Colors.blue, Colors.purple])
                          .createShader(bounds),
                  child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Options()));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/options',
                              (Route<dynamic> route) => false,
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
