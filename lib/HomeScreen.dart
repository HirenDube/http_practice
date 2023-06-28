import 'package:flutter/material.dart';
import 'package:http_practice/AnimeWallpapers.dart';
import 'package:http_practice/AnimeWallpapers2.dart';
import 'package:http_practice/DisplayAnimeDataBase.dart';
import 'package:http_practice/FakestoreapiUsers.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/AlbumsApiData.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/CommentsApiData.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/PhotosApiData.dart';
import 'package:http_practice/ProductsApiData.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/PostsApiData.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/ToDosApiData.dart';
import 'package:http_practice/jsonplaceholder.typicode.com/UsersApiData.dart';

import 'Unsplash Api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Different API's Data"),
      ),
      body: ListView(children: [
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductsApiData())),
          title: Text("Products"),
          subtitle: Text("https://fakestoreapi.com/products"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ToDosApiData())),
          title: Text("To-Dos"),
          subtitle: Text("https://jsonplaceholder.typicode.com/todos"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotosApiData())),
          title: Text("Photos"),
          subtitle: Text("https://jsonplaceholder.typicode.com/photos"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostsApiData())),
          title: Text("Posts"),
          subtitle: Text("https://jsonplaceholder.typicode.com/posts"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CommentsApiData())),
          title: Text("Comments"),
          subtitle: Text("https://jsonplaceholder.typicode.com/comments"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AlbumsApiData())),
          title: Text("Albums"),
          subtitle: Text("https://jsonplaceholder.typicode.com/albums"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UsersApiData())),
          title: Text("Users"),
          subtitle: Text("https://jsonplaceholder.typicode.com/users"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UnsplashWallpaperGetter())),
          title: Text("Unsplash Wallpapers"),
          subtitle: Text("https://api.unsplash.com/search/photos?query=dogs"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => FakestoreapiUsersDisplayData())),
          title: Text("Fake Store API Users"),
          subtitle: Text("https://fakestoreapi.com/users"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => RandomAnimeWallpapers())),
          title: Text("Random Anime Wallpapers"),
          subtitle: Text("https://harrynull.tech/api/wallpapers/random_anime_wallpaper"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => RandomAnimeWallpapers2())),
          title: Text("Random Anime Wallpapers 2"),
          subtitle: Text("https://random-anime-img.p.rapidapi.com/anime"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => DisplayAnimeDataBase())),
          title: Text("Anime Database"),
          subtitle: Text("https://anime-db.p.rapidapi.com/anime"),
        ),

      ]),
    );
  }
}
