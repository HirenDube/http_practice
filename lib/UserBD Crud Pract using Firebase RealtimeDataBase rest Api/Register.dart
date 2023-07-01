import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Decorative%20Widgets.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Display%20Users.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Model%20For%20Firebase%20RealtimeDB.dart';
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Service%20Provider.dart';

class RegisterUsingApi extends StatefulWidget {
  const RegisterUsingApi({Key? key}) : super(key: key);

  @override
  State<RegisterUsingApi> createState() => _RegisterUsingApiState();
}

OutlineInputBorder enabledBorders = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.black, width: 1.5));
OutlineInputBorder focusedBorders = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.blue, width: 1.5));
OutlineInputBorder errorBorders = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.red, width: 1.5));

class _RegisterUsingApiState extends State<RegisterUsingApi> {


  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List originalJson = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndAssign();
  }

  Future<void> fetchAndAssign() async {
    Response response = await get(
        Uri.parse("https://fir-a-to-z-default-rtdb.firebaseio.com/users.json"));
    if (response.statusCode == 200) {
      String encoded = response.body;
      List addThis = jsonDecode(encoded);
      originalJson.addAll(addThis);
      print(originalJson);
    } else {
      Fluttertoast.showToast(msg: " !! Data Not Found !! ");
      throw " !! Data Not Found !! ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DisplayUsers())),
                icon: Icon(Icons.receipt))
          ],
          title: const Text("RegisterUsingApi"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: fullName,
                    decoration: InputDecoration(
                        labelText: "Full Name :",
                        enabledBorder: enabledBorders,
                        focusedBorder: focusedBorders,
                        errorBorder: errorBorders),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: username,
                    decoration: InputDecoration(
                        labelText: "Username : ",
                        enabledBorder: enabledBorders,
                        focusedBorder: focusedBorders,
                        errorBorder: errorBorders),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: password,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: "Password : ",
                        enabledBorder: enabledBorders,
                        focusedBorder: focusedBorders,
                        errorBorder: errorBorders),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: Size(125, 50)),
                      onPressed: () async {
                        if (username.text.isNotEmpty &&
                            password.text.isNotEmpty &&
                            fullName.text.isNotEmpty) {
                          Map newUser =
                              FirebaseRealTimeDB.firebaseRealTimeDBToJson(
                                  modelClassObject: FirebaseRealTimeDB(
                                      username: username.text,
                                      password: password.text,
                                      fullName: fullName.text));
                          originalJson.add(newUser);
                          Response resp = await put(
                              Uri.parse(
                                  "https://fir-a-to-z-default-rtdb.firebaseio.com/users.json"),
                              body: jsonEncode(originalJson));
                          print(resp.statusCode);
                          print(resp.body);
                          username.clear();
                          password.clear();
                          fullName.clear();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(CustomSnackBarMesej(
                            mesej: "User Successfully Created 👍",
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBarMesej(
                                  mesej:
                                      "Either Username or Full Name or Password is empty, \nplease fill them to proceed",
                                  isError: true));
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
