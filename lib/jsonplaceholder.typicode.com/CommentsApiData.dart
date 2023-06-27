import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class CommentsApiData extends StatefulWidget {
  const CommentsApiData({Key? key}) : super(key: key);

  @override
  State<CommentsApiData> createState() => _CommentsApiDataState();
}

class _CommentsApiDataState extends State<CommentsApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CommentsApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForComments(),
          builder: (context, lateData) {
            if (lateData.hasData) {
              List<Comments> apiData = lateData.data!;
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("Name : " +apiData[index].name+"\n"),
                    trailing: Text(
                        "Post ID : ${apiData[index].postId} \n\nID : ${apiData[index].id}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email address : " + apiData[index].email),
                        Text("Comment : "+ apiData[index].body),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: apiData.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
