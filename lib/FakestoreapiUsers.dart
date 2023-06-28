// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';

import 'Model Classes.dart';

class FakestoreapiUsersDisplayData extends StatefulWidget {
  const FakestoreapiUsersDisplayData({Key? key}) : super(key: key);

  @override
  State<FakestoreapiUsersDisplayData> createState() =>
      _FakestoreapiUsersDisplayDataState();
}

class _FakestoreapiUsersDisplayDataState
    extends State<FakestoreapiUsersDisplayData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FakestoreapiUsers"),
      ),
      body: FutureBuilder(
        future: HTTPServices.getDataForFakestoreapiUsers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<FakestoreapiUsers> data = snapshot.data;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                FakestoreapiUsers user = data[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetails(
                                  userDetails: user,
                                )));
                  },
                  title: Text(user.firstname),
                  subtitle: Text(user.lastname),
                );
              },
              itemCount: data.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  FakestoreapiUsers userDetails;

  UserDetails({super.key, required this.userDetails});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var user;
  bool showPassword = false;
  String a = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.userDetails;
    for (int i = 0; i < user.password.length; i++) {
      a += "*";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstname} ${user.lastname}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.account_circle,
                  size: 300,
                  color: Colors.amber,
                ),
              ),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "ID : ${user.id}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "__v : ${user.v}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Username : ${user.username}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                color: Colors.orange,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Password : ${showPassword ? user.password : a}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(showPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_outlined))
                  ],
                ),
              ),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Phone No. : ${user.phone}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "E-mail : ${user.email}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Geo Location : \n      Latitude : ${user.lat}\n      Longitude : ${user.long}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Card(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: Text(
                          """Address : ${user.houseNumber}, ${user.street}, ${user.city} - (${user.zipcode})""",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
