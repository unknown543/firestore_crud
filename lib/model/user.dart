import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _name;
  String _phone;
  List<User> _user;
  User({String name, String phone}) {
    this._name = name;
    this._phone = phone;
  }
  User.fromJson(DocumentSnapshot json)
      : this._name = json["name"],
        this._phone = json["phone"];

  String get name => _name;
  String get phone => _phone;
  set setName(String name) => this._name = name;
  set setPhone(String phone) => this._phone = phone;
  List<User> get user => _user;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['phone'] = this._phone;
    return data;
  }
}
