import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class RandomAnimeWallpapers extends StatefulWidget {
  const RandomAnimeWallpapers({Key? key}) : super(key: key);

  @override
  State<RandomAnimeWallpapers> createState() => _RandomAnimeWallpapersState();
}

class _RandomAnimeWallpapersState extends State<RandomAnimeWallpapers> {
  List one = [
    "https://i.redd.it/fnvok9b7eqz51.png",
    "https://i.redd.it/o9y3ulkctoe61.png",
    "https://i.redd.it/ny6y4guoic151.png",
    "https://i.redd.it/g9okjn3vvfj61.png",
    "https://i.redd.it/rytqv0qbmkj81.jpg",
    'https://i.imgur.com/BQ9iVyz.jpg',
    "https://i.redd.it/s4dzt5zvn7q91.jpg",
    "https://i.redd.it/1opu9aggxbr31.png",
    'https://www.reddit.com/gallery/k0tubi',
    'https://i.redd.it/3f5mkqf9ebe91.jpg'
  ];

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
            future: HTTPServices.getDataForRandomAnimeWallpapers(noOfImages: 1),
            builder: (context, snapdata) {
              if (snapdata.hasData) {
                List imageLinks = snapdata.data!;

                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      imageLinks[0],
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
                            var bytes = await Dio().get(imageLinks[0],
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
