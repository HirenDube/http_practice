import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';

import '../Model Classes.dart';

class PhotosApiData extends StatefulWidget {
  @override
  State<PhotosApiData> createState() => _PhotosApiDataState();
}

class _PhotosApiDataState extends State<PhotosApiData> {
  late Future apiDAta;

  // static int i = 1;
  List<ToDos> todoData = [];

  // void initState() {
  //   super.initState;
  //   getData();
  // }
  //
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
  void initState() {
    // TODO: implement initState
    super.initState();
    apiDAta = HTTPServices.getDataForPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: const Text("PhotosApiData"),
        ),
        body: FutureBuilder(
          future: apiDAta,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<Photos> b = snapshot.data!;
              return ListView(
                children: b
                    .map((e) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              tileColor: Colors.white,
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
