import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../repo/repo.dart';
import '../provider/firebase.dart';

class FetchUsingWhere extends StatefulWidget {
  @override
  _FetchUsingWhereState createState() => _FetchUsingWhereState();
}

class _FetchUsingWhereState extends State<FetchUsingWhere> {
  final _reop = Repository();
  @override
  void dispose() {
    Provider.of<FirebaseProvider>(context, listen: false).setName = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Where Condition")),
        body: Consumer<FirebaseProvider>(
          builder: (context, model, _) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        TextField(
                          onChanged: (String value) => model.setName = value,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: model.getName == null
                        ? Text("Please Enter Data")
                        : StreamBuilder<QuerySnapshot>(
                            stream: _reop.fetchUSingWhere(
                                name: model.getName ?? ""),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                String phone =
                                    snapshot.data.documents.isNotEmpty
                                        ? snapshot.data.documents[0]["phone"]
                                        : "not found";
                                return Text(phone);
                              } else {
                                return Text("No Data");
                              }
                            },
                          )),
              ],
            );
          },
        ));
  }
}
