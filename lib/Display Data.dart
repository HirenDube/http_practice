import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_practice/HTTP%20Services.dart';

import 'Model Classes.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // static int i = 1;
  List<ToDos> todoData = [];

  // void initState() {
  //   super.initState;
  //   getData();
  // }

  // getData() async {
  //   Response response = await get(
  //     Uri.https("jsonplaceholder.typicode.com", "todos"),
  //   );
  //   if (response.statusCode == 200) {
  //     List a = jsonDecode(response.body);
  //     print(a);
  //     for (var element in a) {
  //       todoData.add(ToDos.fromJson(element));
  //     }
  //
  //     setState(() {});
  //   } else {
  //     throw "no data found in the url !!!!";
  //   }
  // }
  //
  //
  // getData() async {
  //   todoData = await HTTPServices.getData();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: const Text("HTTP practice"),
        ),
        body: FutureBuilder(
          future: HTTPServices.getDataForPhotos(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<Photos> b = snapshot.data!;
              return ListView(
                children: b
                    .map((e) =>
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          tileColor:
                          e.id % 2 == 0 ? Colors.black : Colors.white,
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e.id.toString(),
                                style: TextStyle(color: Colors.amber),
                              ),
                              Image.network(
                                e.url,
                                height: 200,
                                width: 200,
                              ),
                              Image.network(
                                e.thumbnailUrl,
                                height: 200,
                                width: 200,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            e.title,
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ),
                        Divider()
                      ],
                    ))
                    .toList(),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: LinearProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
