import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class RandomAnimeWallpapers2 extends StatefulWidget {
  const RandomAnimeWallpapers2({Key? key}) : super(key: key);

  @override
  State<RandomAnimeWallpapers2> createState() => _RandomAnimeWallpapers2State();
}

class _RandomAnimeWallpapers2State extends State<RandomAnimeWallpapers2> {

  bool loaded = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
          title: Text("RandomAnimeWallpapers"),
        ),
        body: FutureBuilder(
            future: HTTPServices.getDataForRandomAnimeWallpapers2(),
            builder: (context, snapdata) {
              if (snapdata.hasData) {
                String imageLink = snapdata.data!;

                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      imageLink,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          loaded = true;
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        loaded = false;
                        return Text("Image couldn't be loaded, perhaps deleted by the owner !!");
                      },
                    ),
                     ElevatedButton(
                        onPressed: () async {
                          if (loaded) {
                            var bytes = await Dio().get(imageLink,
                                                          options:
                                                          Options(responseType: ResponseType.bytes));
                            ImageGallerySaver.saveImage(bytes.data,
                                                          quality: 100,
                                                          name: "Image" +
                                                              DateTime.now()
                                                                  .microsecondsSinceEpoch
                                                                  .toString() +
                                                              ".jpg");
                            Fluttertoast.showToast(msg: "Image Download Success");
                          } else {
                            Fluttertoast.showToast(msg: "Image not available");
                          }
                        },
                        child: Text("Download"))
                  ],
                ));
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }
}
