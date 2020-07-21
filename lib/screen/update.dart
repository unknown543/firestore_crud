import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../repo/repo.dart';

class UpdateData extends StatelessWidget {
  final String id;
  final User user;
  final _key = GlobalKey<ScaffoldState>();
  UpdateData({this.id, this.user}) {
    _nameController.text = user.name;
    _phoneController.text = user.phone;
  }
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _repo = Repository();
  Future<void> update() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      showSnackBar(Colors.red, "Enter Data");
    } else {
      user.setName = _nameController.text.toString();
      user.setPhone = _phoneController.text.toString();
      await _repo.updateData(documentId: id, map: user.toJson());
      showSnackBar(Colors.green, "Update data succefully");
    }
  }

  void showSnackBar(Color color, String msg) {
    _key.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text("Update Data")),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "name",
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "phone",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text("Update Data"),
                onPressed: update,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
