import 'package:bao_ve_tre_em/link_tre_chi_tiet_screen.dart';
import 'package:flutter/material.dart';

class LinkCapQuyen2Screen extends StatefulWidget {
  const LinkCapQuyen2Screen({super.key});

  @override
  State<LinkCapQuyen2Screen> createState() => _LinkCapQuyen2ScreenState();
}

class _LinkCapQuyen2ScreenState extends State<LinkCapQuyen2Screen> {
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
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/bvte6.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                  width: 330,
                  child: Text(
                      "Để kích hoạt các tính năng của BVTE hoạt động đúng, vui lòng cấp tất cả các quyền cần thiết.")),
              Transform.scale(
                  scale: 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: false,
                        onChanged: (value) {},
                        title: const Text("Quyền truy cập",
                            style: TextStyle(fontSize: 14)),
                        subtitle: const Text(
                          "Hạn chế thời gian sử dụng màn hình và ứng dụng cho thiết bị này.",
                          style: TextStyle(fontSize: 12),
                        ),
                        secondary: const Icon(Icons.lock),
                      ),
                    ),
                  )),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (value) {},
                      title:
                          const Text("Quyền vị trí", style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Xem vị trí thời gian thực và thiết lập một số vùng khu vực cho thiết bị này.",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (value) {},
                      title: const Text("Quyền người dùng sử dụng",
                          style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Xem thời gian sử dụng màn hình và ứng dụng cho thiết bị này.",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (value) {},
                      title: const Text("Quyền quản trị thiết bị",
                          style: TextStyle(fontSize: 14)),
                      subtitle: const Text(
                        "Đảm bảo hoạt động ổn định của BVTE trong nền và giảm khả năng bị gỡ ứng dụng.",
                        style: TextStyle(fontSize: 12),
                      ),
                      secondary: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.purple])
                        .createShader(bounds),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LinkChiTietTreScreen()));
                        },
                        child: const Text(
                          "Xác nhận",
                        ))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
