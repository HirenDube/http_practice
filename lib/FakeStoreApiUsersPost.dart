import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class FakeStoreApiUsersPost extends StatefulWidget {
  const FakeStoreApiUsersPost({Key? key}) : super(key: key);

  @override
  State<FakeStoreApiUsersPost> createState() => _FakeStoreApiUsersPostState();
}

class _FakeStoreApiUsersPostState extends State<FakeStoreApiUsersPost> {
  String mesej = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FakeStoreApiUsersPost"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  String mesej = await HTTPServices.postDataForFakestoreapiUsers(
                      dataBody: FakestoreapiUsers.fakeStoreApiUserstoJson(
                          object: FakestoreapiUsers(
                              v: 55,
                              email: "email",
                              username: "username",
                              password: "password",
                              phone: "phone",
                              firstname: "firstname",
                              lastname: "lastname",
                              city: "city",
                              street: "street",
                              zipcode: "zipcode",
                              lat: "lat",
                              long: "long",
                              houseNumber: 2799,
                              id: 1000)));
                  setState(() {
                    this.mesej = mesej;
                  });
                },
                child: Text("Add Data")),
            Text(
              mesej,
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
