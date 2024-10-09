import 'package:bao_ve_tre_em/models/Children.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ParentService _parentService = ParentService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Children>> getData() async {
    return await _parentService.getChild();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Danh sách trẻ"),
            ),
            body: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Children> l = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 30,
                      children: [
                        for (int i = 0; i < l.length; i++)
                          Container(
                            width: 70,
                            height: 70,
                            color: Colors.red,
                            child: Center(child: Text(l[i].name)),
                          )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
