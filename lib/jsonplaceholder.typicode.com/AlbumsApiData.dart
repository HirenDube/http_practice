import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class AlbumsApiData extends StatefulWidget {
  const AlbumsApiData({Key? key}) : super(key: key);

  @override
  State<AlbumsApiData> createState() => _AlbumsApiDataState();
}

class _AlbumsApiDataState extends State<AlbumsApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AlbumsApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForAlbums(),
          builder: (context, lateData) {
            if (lateData.hasData) {
              List<Albums> data = lateData.data!;
              return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index].title),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("\nUser ID : ${data[index].userId}"),
                      Text("\nID : ${data[index].id}"),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: data.length,
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
