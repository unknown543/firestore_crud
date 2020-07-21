import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../screen/where_condition.dart';
import '../screen/update.dart';
import '../repo/repo.dart';
import '../widget/insertdata.dart';

class HomeScreen extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final Repository _repo = Repository();
  final _list = ["where"];
  Future<bool> showDialogs(BuildContext context, String documentID) async {
    return await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Are You Sure To You Want Yo Delete This Record"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Yes"),
              onPressed: () async {
                Navigator.pop(ctx, true);
                await _repo.deleteDocument(documentID: documentID);
                showSnackBar(Colors.red, "Record Deleted Successfully");
              },
            ),
            FlatButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(ctx, false);
              },
            ),
          ],
        );
      },
    );
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
    List<User> _user;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("FireStore Crud"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == "where") {
                Navigator.push(
                    context,
                    PageTransition(
                        child: FetchUsingWhere(),
                        type: PageTransitionType.fade));
              }
            },
            itemBuilder: (ctx) => _list
                .map((listdata) => PopupMenuItem<String>(
                      child: Text(listdata),
                      value: listdata,
                    ))
                .toList(),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            _user =
                snapshot.data.documents.map((e) => User.fromJson(e)).toList();
            return _user.isEmpty
                ? Center(child: const Text("No Data"))
                : ListView.builder(
                    cacheExtent: 100.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, i) => Dismissible(
                      key: ValueKey(snapshot.data.documents[i].documentID),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        color: Colors.red,
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                      ),
                      confirmDismiss: (direction) {
                        return showDialogs(
                            context, snapshot.data.documents[i].documentID);
                      },
                      onDismissed: (direction) {
                        print(direction.toString());
                      },
                      child: Card(
                        color: Colors.cyan,
                        margin: const EdgeInsets.all(5.0),
                        elevation: 2.0,
                        child: ListTile(
                          subtitle: Text(_user[i].phone),
                          title: Text(_user[i].name),
                          trailing: FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: UpdateData(
                                      id: snapshot.data.documents[i].documentID,
                                      user: _user[i],
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.mode_edit),
                            label: Text("Edit"),
                          ),
                          // subtitle:
                          //     Text(snapshot.data.documents[i].documentID.toString()),
                        ),
                      ),
                    ),
                    itemCount: _user.length,
                  );
          }
        },
        stream: _repo.fetchMultipalDocument(),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => InsertData(),
          );
        },
        child: Card(
          shape: StadiumBorder(),
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              "Add New",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
