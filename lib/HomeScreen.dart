import 'package:flutter/material.dart';
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
      ]),
    );
  }
}
