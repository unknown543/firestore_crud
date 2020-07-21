import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repo/repo.dart';
import '../provider/firebase.dart';
import '../model/user.dart';

class InsertData extends StatefulWidget {
  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final _phoneFocus = FocusNode();
  final _key = GlobalKey<FormState>();
  String name, phone;
  User _user = User();
  final _repo = Repository();
  void _insert() {
    if (_user.name.isNotEmpty && _user.phone.isNotEmpty) {
      _repo.insertMultipaleDocument(map: _user.toJson());
      Navigator.pop(context);
    } else {
      // print("error");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, model, _) {
        return ListView(
          padding: const EdgeInsets.all(10.0),
          shrinkWrap: true,
          children: <Widget>[
            Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (data) {
                      _user.setName = data ?? "";
                      model.nameValidation(data: data);
                    },
                    validator: (_) => model.nameMessage,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_phoneFocus),
                    decoration: InputDecoration(
                      labelText: "Name",
                      errorText: model.nameMessage,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    onChanged: (data) {
                      _user.setPhone = data ?? "";
                      model.phoneValidation(data: data);
                    },
                    validator: (_) => model.pohoneMessage,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      errorText: model.pohoneMessage,
                    ),
                  ),
                  Container(height: 20.0),
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      child: const Text("Insert Data"),
                      onPressed: _insert,
                    ),
                  ),
                  Container(height: 200.0),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
