import 'App.dart';

class Children {
  String _fcmToken;
  List<App> _listApp;
  String _name;
  List<String> _blockList;

  Children(this._fcmToken, this._listApp, this._name, this._blockList);

  String get fcmToken => _fcmToken;

  set fcmToken(String value) {
    _fcmToken = value;
  }

  List<App> get listApp => _listApp;

  set listApp(List<App> value) {
    _listApp = value;
  }

  factory Children.fromMap(Map<String, dynamic> map) {
    return Children(
        map['fcmToken'] as String,
        (map['appList'] as List<dynamic>)
            .map((appMap) => App.fromMap(appMap as Map<String, dynamic>))
            .toList(),
        map['name'],
        (map['blockList'] as List<dynamic>)
            .map((item) => item as String)
            .toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'fcmToken': _fcmToken,
      'appList': _listApp.map((app) => app.toMap()).toList(),
      'name': _name,
      'blockList': _blockList.toList()
    };
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<String> get blockList => _blockList;

  set blockList(List<String> value) {
    _blockList = value;
  }
}
