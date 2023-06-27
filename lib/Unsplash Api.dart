// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class UnsplashWallpaperGetter extends StatefulWidget {
  String searchQuery = "";

  UnsplashWallpaperGetter({this.searchQuery = "fire"});

  @override
  State<UnsplashWallpaperGetter> createState() =>
      _UnsplashWallpaperGetterState();
}

class _UnsplashWallpaperGetterState extends State<UnsplashWallpaperGetter> {
  ScrollController scrollController = ScrollController();
  int page = 1, gridCount = 2;
  bool loading = false;

  static List<UnsplashWallpapers> wallpaperData = [];

  Response? bytes;

  loadMore() async {
    var nextData = await HTTPServices.getDataForUnsplashApi(
        perPage: 30,
        searchQuery: widget.searchQuery.isNotEmpty
            ? widget.searchQuery.replaceAll(" ", "_")
            : "fire",
        page: page);
    wallpaperData.addAll(nextData);
    if (loading) {
      setState(() {
        loading = false;
        Fluttertoast.showToast(msg: "60 More Images Loaded");
      });
    }

    return wallpaperData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(0,
              duration: const Duration(seconds: 1), curve: Curves.linear);
        },
        child: const Icon(CupertinoIcons.up_arrow),
      ),
      extendBody: true,
      bottomNavigationBar: Material(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.amber,
          ),
          height: 50,
          child: TextButton(
              onPressed: () async {
                page++;
                setState(() {
                  loading = true;
                });
              },
              child: const Text(
                "Load More",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        ),
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        title: const Text("MyApp"),
        actions: [
          DropdownButton(
              icon: const Icon(Icons.apps),
              items: [
                const DropdownMenuItem(value: 1, child: Text("1")),
                const DropdownMenuItem(value: 2, child: Text("2")),
                const DropdownMenuItem(value: 3, child: Text("3")),
                // DropdownMenuItem(value: 4, child: Text("4")),
              ],
              onChanged: (value) {
                setState(() {
                  gridCount = value!;
                });
              }),
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: searcher()),
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: page == 1
                  ? HTTPServices.getDataForUnsplashApi(
                  perPage: 30,
                  searchQuery: widget.searchQuery.isNotEmpty
                      ? widget.searchQuery.replaceAll(" ", "_")
                      : "fire")
                  : loadMore(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  wallpaperData = snapshot.data!;
                  if (wallpaperData.length != 0) {
                    print("Length = ${wallpaperData.length}");
                    return GridView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCount,
                        ),
                        children: List.generate(
                            wallpaperData.length,
                            (index) => AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Card(
                                    child: GestureDetector(
                                      onTap: () async {
                                        bytes = await Dio().get(
                                            wallpaperData[index].full,
                                            options: Options(
                                                responseType:
                                                    ResponseType.bytes));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                      bottomNavigationBar:
                                                          Material(
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20)),
                                                            color: Colors.amber,
                                                          ),
                                                          height: 50,
                                                          child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                try {
                                                                  ImageGallerySaver.saveImage(
                                                                      bytes!.data,
                                                                      quality:
                                                                          100,
                                                                      name: "Image" +
                                                                          DateTime.now()
                                                                              .microsecondsSinceEpoch
                                                                              .toString() +
                                                                          ".jpg");
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Image Download Success");
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                                // Response a = await get(
                                                                //     Uri.parse(
                                                                //         wallpaperData[
                                                                //                 index]
                                                                //             .full));
                                                                // ImageGallerySaver.saveImage(
                                                                //     a.bodyBytes,
                                                                //     quality: 100,
                                                                //     name: DateTime.now()
                                                                //             .microsecondsSinceEpoch
                                                                //             .toString() +
                                                                        ".jpg");
                                                              // },
                                                              child: const Text(
                                                                "Download",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                      ),
                                                      appBar: AppBar(
                                                          actions: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  // File shareIt = await File.fromUri(Uri.parse(wallpaperData[index].full));
                                                                  Share.share(wallpaperData[index].full);
                                                                  // Share.shareXFiles(
                                                                  //     [
                                                                  //       XFile(shareIt.path)
                                                                  //     ]);
                                                                },
                                                                icon: Icon(Icons
                                                                    .share))
                                                          ],
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20))),
                                                          title: Text(widget
                                                              .searchQuery)),
                                                      body: Center(
                                                        child: Image.network(
                                                            wallpaperData[index]
                                                                .full),
                                                      ),
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  wallpaperData[index].thumb,
                                                ))),
                                      ),
                                    ),
                                  ),
                                )));
                  } else {
                    return const Center(
                      child: Text("No Results Found"),
                    );
                  }
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: LinearProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
          loading ? const CircularProgressIndicator() : const SizedBox()
        ],
      ),
    );
  }
}

class searcher extends SearchDelegate {
  String searchQuery = "";

  @override
  // TODO: implement textInputAction
  TextInputAction get textInputAction {
    searchQuery = query;
    return TextInputAction.search;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            searchQuery = query;
            print(searchQuery);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UnsplashWallpaperGetter(
                          searchQuery: searchQuery,
                        )));
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const SizedBox();
  }
}

// access key : qgg_n0YFA95x11q18FhAw3KdN2DPZGVOXvu73G1u9Jo
//secret key : sH-Vnylb8HvQIw1ddvLOcC6z_fE97wUjhLKp6HEQ0Ok
