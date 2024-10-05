import 'package:bao_ve_tre_em/children/child_instructions.dart';
import 'package:bao_ve_tre_em/children/child_confirm.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';

class ChildLinkCode extends StatefulWidget {
  const ChildLinkCode({super.key});

  @override
  State<ChildLinkCode> createState() => _ChildLinkCodeState();
}

class _ChildLinkCodeState extends State<ChildLinkCode> {
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  ParentService _parentService = ParentService();
  @override
  void dispose() {
    _focusNodes.forEach((node) => node.dispose());
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildOTPField(int index) {
    return Expanded(
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
          controller: _controllers[index],
          focusNode: _focusNodes[index],
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
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
            if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 200, 0.2),
                  Color.fromRGBO(255, 100, 100, 0.7)
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
                SizedBox(height: 50),
                Row(
                  children: List.generate(4, (index) => _buildOTPField(index)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChildInstructions()));
                    },
                    child: const Text(
                      "Làm thế nào để có liên kết?",
                      style: TextStyle(color: Colors.blue),
                    )),
                const SizedBox(height: 50),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(colors: [Colors.blue, Colors.purple])
                              .createShader(bounds),
                      child: ElevatedButton(
                        onPressed: () async {
                          String code = _controllers.map((controller) => controller.text).join();

                          // Hiển thị biểu tượng xoay trong khi chờ kết quả từ hàm findUserWithCode
                          showDialog(
                            context: context,
                            barrierDismissible: false, // Ngăn người dùng đóng dialog bằng cách nhấn ra ngoài
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(), // Icon xoay
                              );
                            },
                          );
                          String _email = await _parentService.findUserWithCode(code);
                          Navigator.of(context).pop();

                          if (_email.length>0) {

                            showDialog(context: context, builder: (_) {
                              return  ChildConfirm(email: _email);
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text("Lỗi"),
                                  content: Text("Không có người dùng nào có mã liên kết này."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Đóng"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text(
                          "Tiếp tục",
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ));
  }


}
