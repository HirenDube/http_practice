import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Decorative%20Widgets.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Model%20For%20Firebase%20RealtimeDB.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Register.dart';


class DisplayUsers extends StatefulWidget {
  const DisplayUsers({Key? key}) : super(key: key);

  @override
  State<DisplayUsers> createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {
  List originalJson = [];

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future fetchData() async {
    Response response = await get(
        Uri.parse("https://fir-a-to-z-default-rtdb.firebaseio.com/users.json"));
    if (response.statusCode == 200) {
      String encoded = response.body;
      List<FirebaseRealTimeDB> returnThis =
          FirebaseRealTimeDB.firebaseFromJson(encoded);
      originalJson = jsonDecode(encoded);

      return returnThis;
    } else {
      Fluttertoast.showToast(msg: " !! Data Not Found !! ");
      throw " !! Data Not Found !! ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DisplayUsers"),
        ),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapdata) {
              if (snapdata.hasData) {
                List<FirebaseRealTimeDB> users = snapdata.data;
                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    FirebaseRealTimeDB currentUser = users[index];
                    return ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title: Text(
                                          "Are you sure you want to delete this user ? "),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Map deleteThisUser =
                                                  FirebaseRealTimeDB
                                                      .firebaseRealTimeDBToJson(
                                                          modelClassObject:
                                                              currentUser);
                                              print(
                                                  originalJson[0].runtimeType);
                                              print(deleteThisUser.runtimeType);
                                              originalJson.forEach((e) {
                                                if (e['username'] ==
                                                    deleteThisUser[
                                                        'username']) {
                                                  deleteThisUser = e;
                                                }
                                              });
                                              print(originalJson
                                                  .remove(deleteThisUser));
                                              print(
                                                  "before upload $originalJson");

                                              Response resp = await put(
                                                  Uri.parse(
                                                      "https://fir-a-to-z-default-rtdb.firebaseio.com/users.json"),
                                                  body:
                                                      jsonEncode(originalJson));
                                              print(resp.statusCode);

                                              print(
                                                  "after upload ${resp.body}");

                                              setState(() {});
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(CustomSnackBarMesej(
                                                      mesej:
                                                          "User Deleted Successfully",
                                                      isError: true));
                                            },
                                            child: Text(
                                              "YES",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "NO",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete)),
                      // deleteButton
                      leading: IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title:
                                          const Text("Enter New Credentials"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: username,
                                            decoration: InputDecoration(
                                                enabledBorder: enabledBorders,
                                                focusedBorder: focusedBorders,
                                                labelText: "Username : "),
                                          ),
                                          SizedBox(height: 20),
                                          TextField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: password,
                                            decoration: InputDecoration(
                                                enabledBorder: enabledBorders,
                                                focusedBorder: focusedBorders,
                                                labelText: "Password : "),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Map deleteThisUser = {};
                                              print(
                                                  originalJson[0].runtimeType);
                                              print(deleteThisUser.runtimeType);
                                              originalJson.forEach((e) {
                                                if (e['username'] ==
                                                    currentUser.username) {
                                                  deleteThisUser = e;
                                                }
                                              });
                                              originalJson
                                                  .remove(deleteThisUser);
                                              originalJson.add(FirebaseRealTimeDB
                                                  .firebaseRealTimeDBToJson(
                                                      modelClassObject:
                                                          FirebaseRealTimeDB(
                                                              username:
                                                                  username.text,
                                                              password:
                                                                  password.text,
                                                              fullName: currentUser
                                                                  .fullName)));

                                              Response resp = await put(
                                                  Uri.parse(
                                                      "https://fir-a-to-z-default-rtdb.firebaseio.com/users.json"),
                                                  body:
                                                      jsonEncode(originalJson));

                                              setState(() {});
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(CustomSnackBarMesej(
                                                      mesej:
                                                          "User Updated Successfully",
                                                      isUpdate: true));
                                            },
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.edit)),
                      // update Button
                      title: Text(currentUser.username),
                      subtitle: Text(currentUser.password),
                      onLongPress: () {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg:
                                "This user's Full name is ${currentUser.fullName}");
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
