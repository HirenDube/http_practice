import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class PostsApiData extends StatefulWidget {
  const PostsApiData({Key? key}) : super(key: key);

  @override
  State<PostsApiData> createState() => _PostsApiDataState();
}

class _PostsApiDataState extends State<PostsApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostsApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForPosts(),
          builder: (context, lateData) {
            if (lateData.hasData) {
              List<Posts> postList = lateData.data!;
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Title : '+postList[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("User ID: ${postList[index].userId}"),
                            Text(" ID : ${postList[index].id}")
                          ],
                        ),
                        Text("Post : ${postList[index].body}"),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: postList.length,
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
