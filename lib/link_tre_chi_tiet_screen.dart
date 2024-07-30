import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

const list = ["Tiếng Việt", "English"];

class LinkChiTietTreScreen extends StatefulWidget {
  const LinkChiTietTreScreen({super.key});

  @override
  State<LinkChiTietTreScreen> createState() => _LinkChiTietTreScreenState();
}

class _LinkChiTietTreScreenState extends State<LinkChiTietTreScreen> {
  String _selectedItem = list.first;
  static const Map<String, double> dataChart = {"Đã dùng": 25, "Chưa dùng": 35};

  static const colorList = <Color>[
    Colors.grey,
    Color(0xff0984e3),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                ClipOval(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("assets/images/a4.png"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Huy",
                  style: TextStyle(fontSize: 20),
                ),
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 0),
                  height: 28,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Màu viền
                        width: 2.0, //Độ dày viền
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                    items: <String>['Tiếng Việt', 'English', 'Français']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset('assets/images/vn.png',
                                  width: 24),
                            ),
                            const SizedBox(width: 8),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(4),
                width: 0.95 * size.width,
                height: size.height / 3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Thời gian sử dụng"),
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    Text("Bắt đầu:  8:00"),
                    Text("Kết thúc: 12:00"),
                    PieChart(
                      centerWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "01h 00p",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Hôm nay"),
                        ],
                      ),
                      chartRadius: 100,
                      dataMap: dataChart,
                      chartType: ChartType.ring,
                      baseChartColor: Colors.transparent,
                      colorList: colorList,
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: false,
                        showChartValues: true,
                      ),
                      totalValue: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 2 * size.height / 3 - 90,
                width: 0.95 * size.width,
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const SizedBox(),
                            for (var day in [
                              'Thứ 2',
                              'Thứ 3',
                              'Thứ 4',
                              'Thứ 5',
                              'Thứ 6',
                              'Thứ 7',
                              'CN'
                            ])
                              TableCell(
                                child: Center(child: Text(day)),
                              ),
                          ],
                        ),
                        for (var hour in List.generate(24, (index) => index))
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(child: Text('$hour h')),
                              ),
                              for (var i in List.generate(7, (index) => index))
                                TableCell(
                                  child: Center(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      width: 25,
                                      height: 15,
                                      color: hour < 6
                                          ? Colors.red
                                          : Colors
                                              .green, // Điều kiện kiểm tra giờ
                                    ),
                                  )),
                                ),
                            ],
                          ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
