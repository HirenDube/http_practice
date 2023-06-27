import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as HTTP;

import 'Model Classes.dart';

class HTTPServices {
  static Future<List<ToDos>> getDataForToDos(
      {String url = "https://jsonplaceholder.typicode.com/todos"}) async {
    HTTP.Response response = await HTTP.get(
      // Uri.https("jsonplaceholder.typicode.com", "todos"),
      Uri.https("${url.split("//")[1].split("/")[0]}",
          "${url.split("//")[1].split("/")[1]}"),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = jsonDecode(response.body);
      List<ToDos> convertedDataToBeUsed = convertedData
          .map((data) => ToDos.fromJsonData(jsonData: data))
          .toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Photos>> getDataForPhotos(
      {String url = "https://jsonplaceholder.typicode.com/photos"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = jsonDecode(response.body);
      List<Photos> convertedDataToBeUsed = convertedData
          .map((data) => Photos.fromJsonData(jsonData: data))
          .toList();

      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Products>> getDataForProducts(
      {String url = "https://fakestoreapi.com/products"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = await jsonDecode(response.body);
      List<Products> convertedDataToBeUsed = convertedData.map((mapOnIndex) {
        var tempData = Products.fromJsonData(jsonData: mapOnIndex);
        return tempData;
      }).toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Albums>> getDataForAlbums(
      {String url = "https://jsonplaceholder.typicode.com/albums"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = await jsonDecode(response.body);
      List<Albums> convertedDataToBeUsed = convertedData.map((mapOnIndex) {
        var tempData = Albums.fromJsonData(jsonData: mapOnIndex);
        return tempData;
      }).toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Posts>> getDataForPosts(
      {String url = "https://jsonplaceholder.typicode.com/posts"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = await jsonDecode(response.body);
      List<Posts> convertedDataToBeUsed = convertedData.map((mapOnIndex) {
        var tempData = Posts.fromJsonData(jsonData: mapOnIndex);
        return tempData;
      }).toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Comments>> getDataForComments(
      {String url = "https://jsonplaceholder.typicode.com/comments"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = await jsonDecode(response.body);
      List<Comments> convertedDataToBeUsed = convertedData.map((mapOnIndex) {
        var tempData = Comments.fromJsonData(jsonData: mapOnIndex);
        return tempData;
      }).toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future<List<Users>> getDataForUsers(
      {String url = "https://jsonplaceholder.typicode.com/users"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = await jsonDecode(response.body);
      List<Users> convertedDataToBeUsed = convertedData.map((mapOnIndex) {
        var tempData = Users.fromJsonData(jsonData: mapOnIndex);
        return tempData;
      }).toList();
      return convertedDataToBeUsed;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future getDataForUnsplashApi(
      {String url =
          "https://api.unsplash.com/search/photos?query=fire&client_id=qgg_n0YFA95x11q18FhAw3KdN2DPZGVOXvu73G1u9Jo",
      String searchQuery = "fire",
      String orientation = "portrait",
      int perPage = 20,int page = 1}) async {
    HTTP.Response rawData = await HTTP.get(Uri.parse(
        "https://api.unsplash.com/search/photos?query=$searchQuery&per_page=$perPage&orientation=$orientation&page=$page&client_id=qgg_n0YFA95x11q18FhAw3KdN2DPZGVOXvu73G1u9Jo"));

    print(rawData.statusCode);
    if (rawData.statusCode == 200) {
      Map data = jsonDecode(rawData.body);

      List temp = data['results'];

      List<UnsplashWallpapers> returningList = temp
          .map((e) => UnsplashWallpapers.fromJsonData(jsonData: e))
          .toList();
      return returningList;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }
}
