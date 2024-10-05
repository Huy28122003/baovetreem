import 'package:bao_ve_tre_em/models/Parent.dart';
import 'package:bao_ve_tre_em/parent/sign_in.dart';

class App{
  String _packgeName;
  bool _state;
  String _time;
  String _appName;

  App(this._packgeName, this._state,this._time,this._appName);

  bool get state => _state;

  set state(bool value) {
    _state = value;
  }

  String get packgeName => _packgeName;

  set packgeName(String value) {
    _packgeName = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  factory App.fromMap(Map<String,dynamic> map){
    return App(map['packageName'] as String, map['state'] as bool, map['spendTime'],map['appName']);
  }

  Map<String,dynamic> toMap(){
    return{
      'packageName': _packgeName,
      'spendTime' : _time,
      'state' : _state,
      'appName':_appName
    };
  }
}