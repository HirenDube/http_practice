import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model Classes.dart';

class DisplayAnimeDataBase extends StatefulWidget {
  @override
  State<DisplayAnimeDataBase> createState() => _DisplayAnimeDataBaseState();
}

class _DisplayAnimeDataBaseState extends State<DisplayAnimeDataBase> {
  int page = 1;
  String genre = "Action", order = "asc";
  ScrollController goUp = ScrollController();

  List<ToDos> todoData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            DropdownButton(
                icon: Icon(Icons.apps),
                items: const [
                  DropdownMenuItem(
                      value: "Award Winning", child: Text("Award Winning")),
                  DropdownMenuItem(value: "Action", child: Text("Action")),
                  DropdownMenuItem(value: "Suspense", child: Text("Suspense")),
                  DropdownMenuItem(value: "Horror", child: Text("Horror")),
                  DropdownMenuItem(value: "Ecchi", child: Text("Ecchi")),
                  DropdownMenuItem(
                      value: "Avant Garde", child: Text("Avant Garde")),
                  DropdownMenuItem(value: "Sports", child: Text("Sports")),
                  DropdownMenuItem(
                      value: "Supernatural", child: Text("Supernatural")),
                  DropdownMenuItem(value: "Fantasy", child: Text("Fantasy")),
                  DropdownMenuItem(value: "Gourmet", child: Text("Gourmet")),
                  DropdownMenuItem(
                      value: "Boys Love", child: Text("Boys Love")),
                  DropdownMenuItem(value: "Drama", child: Text("Drama")),
                  DropdownMenuItem(value: "Comedy", child: Text("Comedy")),
                  DropdownMenuItem(value: "Mystery", child: Text("Mystery")),
                  DropdownMenuItem(
                      value: "Girls Love", child: Text("Girls Love")),
                  DropdownMenuItem(
                      value: "Slice of Life", child: Text("Slice of Life")),
                  DropdownMenuItem(
                      value: "Adventure", child: Text("Adventure")),
                  DropdownMenuItem(value: "Romance", child: Text("Romance")),
                  DropdownMenuItem(value: "Sci-Fi", child: Text("Sci-Fi")),
                  DropdownMenuItem(value: "Erotica", child: Text("Erotica")),
                  DropdownMenuItem(value: "Hentai", child: Text("Hentai")),
                ],
                onChanged: (value) {
                  setState(() {
                    goUp.animateTo(0,
                        duration: Duration(seconds: 1), curve: Curves.linear);
                    genre = value!;
                  });

                }),
            DropdownButton(
                icon: Icon(Icons.sort),
                items: const [
                  DropdownMenuItem(value: "asc", child: Text("Ascending")),
                  DropdownMenuItem(value: "desc", child: Text("Descending")),
                ],
                onChanged: (value) {
                  setState(() {
                    goUp.animateTo(0,
                        duration: Duration(seconds: 1), curve: Curves.linear);
                    order = value!;
                  });
                }),
            DropdownButton(
                icon: Icon(Icons.restore_page),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("1")),
                  DropdownMenuItem(value: 2, child: Text("2")),
                  DropdownMenuItem(value: 3, child: Text("3")),
                  DropdownMenuItem(value: 4, child: Text("4")),
                  DropdownMenuItem(value: 5, child: Text("5")),
                  DropdownMenuItem(value: 6, child: Text("6")),
                  DropdownMenuItem(value: 7, child: Text("7")),
                  DropdownMenuItem(value: 8, child: Text("8")),
                  DropdownMenuItem(value: 9, child: Text("9")),
                  DropdownMenuItem(value: 10, child: Text("10")),
                  DropdownMenuItem(value: 11, child: Text("11")),
                  DropdownMenuItem(value: 12, child: Text("12")),
                  DropdownMenuItem(value: 13, child: Text("13")),
                  DropdownMenuItem(value: 14, child: Text("14")),
                  DropdownMenuItem(value: 15, child: Text("15")),
                  DropdownMenuItem(value: 16, child: Text("16")),
                  DropdownMenuItem(value: 17, child: Text("17")),
                  DropdownMenuItem(value: 18, child: Text("18")),
                  DropdownMenuItem(value: 19, child: Text("19")),
                  DropdownMenuItem(value: 20, child: Text("20")),
                ],
                onChanged: (value) {
                  setState(() {
                    goUp.animateTo(0,
                        duration: Duration(seconds: 1), curve: Curves.linear);
                    page = value!;
                  });
                }),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Colors.yellowAccent,
          title: const Text("Anime Database"),
        ),
        body: FutureBuilder(
          future: HTTPServices.getDataForAnimeDatabase(
              genres: genre, sortOrder: order, url: "", size: 20, page: page),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<AnimeDatabase> database = snapshot.data!;
              return ListView.separated(
                controller: goUp,
                itemBuilder: (BuildContext context, int index) {
                  AnimeDatabase dataOnIndex = database[index];
                  return ListTile(
                    title: Text(dataOnIndex.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Image.network(
                            dataOnIndex.image,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                  "Image couldn't be loaded, perhaps deleted by the owner !!");
                            },
                          ),
                        ),
                        // Text(
                        //     "Alternative Titles : ${dataOnIndex.alternativeTitles.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(",", ",\n")}"),
                        Text("ID : ${dataOnIndex.id}"),
                        Text("Type : ${dataOnIndex.type}"),
                        Text("Ranking : ${dataOnIndex.ranking}"),
                        Text(
                            "Genres : ${dataOnIndex.genres.toString().replaceAll("[", "").replaceAll("]", "")}"),
                        Text(
                            "No of total Episodes : ${dataOnIndex.noOfEpisode}"),
                        Text(
                            "Alternative Titles : ${dataOnIndex.alternativeTitles[0]}"),
                        Text("Link to MAL :"),
                        TextButton(
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse(dataOnIndex.malLink),
                                  mode: LaunchMode.externalApplication)) {
                                Fluttertoast.showToast(
                                    msg: "Can't launch this url");
                                throw "can't lauch this url";
                              }
                            },
                            child: Text(dataOnIndex.malLink)),
                        Text("Description :\n${dataOnIndex.decription}"),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: database.length,
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
