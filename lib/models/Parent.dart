import 'Children.dart';

class Parent{
  String _id;
  List<Children> _children;
  String _linkCode;
  String _email;

  Parent(this._id, this._children,this._linkCode,this._email);

  List<Children> get children => _children;

  set children(List<Children> value) {
    _children = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get linkCode => _linkCode;

  set linkCode(String value) {
    _linkCode = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  factory Parent.fromMap(Map<String,dynamic> map,userId){
    return Parent(userId, map['childList'], map['linkCode'], map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'childList': _children.map((child) => child.toMap()).toList(),
      'linkCode': _linkCode,
      'email':_email
    };
  }
}
