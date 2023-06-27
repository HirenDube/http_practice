import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class ToDosApiData extends StatefulWidget {
  const ToDosApiData({Key? key}) : super(key: key);

  @override
  State<ToDosApiData> createState() => _ToDosApiDataState();
}

class _ToDosApiDataState extends State<ToDosApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDosApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForToDos(),
          builder: (context, delayedData) {
            if (delayedData.hasData) {
              List<ToDos> data = delayedData.data!;
              return ListView(
                children: data
                    .map((e) => CheckboxListTile(
                          title: Text(e.title),
                          value: e.completed,
                          subtitle: Text("ID : ${e.id} User ID : ${e.userId}"),
                          onChanged: (bool? value) {
                            Fluttertoast.showToast(
                                msg:
                                    "These values are by default and can't tbe changed by you");
                          },
                        ))
                    .toList(),
              );
            } else {
              return Center(
                child: LinearProgressIndicator(),
              );
            }
          }),
    );
  }
}
