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

  static Future<List<UnsplashWallpapers>> getDataForUnsplashApi(
      {String url =
          "https://api.unsplash.com/search/photos?query=fire&client_id=qgg_n0YFA95x11q18FhAw3KdN2DPZGVOXvu73G1u9Jo",
      String searchQuery = "fire",
      String orientation = "portrait",
      int perPage = 20,
      int page = 1}) async {
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

  static Future<List> getDataForRandomAnimeWallpapers(
      {String url =
          "https://harrynull.tech/api/wallpapers/random_anime_wallpaper",
      int noOfImages = 10}) async {
    List resultingList = [];
    for (int i = 1; i <= noOfImages; i++) {
      HTTP.Response listOfLinks = await HTTP.get(Uri.parse(url));
      if (listOfLinks.statusCode == 200) {
        Map data1 = jsonDecode(listOfLinks.body);
        resultingList.add(data1['img']);
        // print(resultingList);
      } else {
        Fluttertoast.showToast(msg: "No data found !!!");
        throw "Requested data not available !!";
      }
    }
    return resultingList;
  }

  static Future<List<FakestoreapiUsers>> getDataForFakestoreapiUsers(
      {String url = "https://fakestoreapi.com/users"}) async {
    HTTP.Response response = await HTTP.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("data Entered");
      List rawData = jsonDecode(response.body);
      print("data decoded");

      List<FakestoreapiUsers> resultList = rawData
          .map((e) => FakestoreapiUsers.fromJsonData(jsonData: e))
          .toList();
      print("data Exited");

      return resultList;
    } else {
      Fluttertoast.showToast(msg: "Data not found !!");
      throw "!!! Data not available !!! ";
    }
  }

  static Future postDataForProducts(
      {required Map dataBody,String url = "https://fakestoreapi.com/products"}) async {
    HTTP.Response response = await HTTP.post(
      Uri.parse(url),
      body: jsonEncode(dataBody)
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }

  static Future postDataForFakestoreapiUsers(
      {required Map dataBody,String url = "https://fakestoreapi.com/users"}) async {
    HTTP.Response response = await HTTP.post(Uri.parse(url),body: jsonEncode(dataBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      Fluttertoast.showToast(msg: "Data not found !!");
      throw "!!! Data not available !!! ";
    }
  }

  static Future<String> getDataForRandomAnimeWallpapers2(
      {String url = "https://random-anime-img.p.rapidapi.com/anime"}) async {
    Map<String, String> headers = {
      'X-RapidAPI-Key': '1d9649b6b2mshf5e531a70012aa3p10e8a7jsn36f9f5d8dd25',
      'X-RapidAPI-Host': 'random-anime-img.p.rapidapi.com'
    };

    HTTP.Response a = await HTTP.get(Uri.parse(url), headers: headers);
    Map urlData = jsonDecode(a.body);

    return urlData['url'];
  }

  static Future<List<AnimeDatabase>> getDataForAnimeDatabase(
      {int page = 1,
      int size = 10,
      String genres = "Action",
      String sortBy = "ranking",
      String sortOrder = "asc",
      String url =
          "https://anime-db.p.rapidapi.com/anime?page=5&size=3&genres=Ecchi&sortBy=ranking&sortOrder=asc"}) async {
    String url0 = url == ""
        ? "https://anime-db.p.rapidapi.com/anime?page=$page&size=$size&genres=$genres&sortBy=$sortBy&sortOrder=$sortOrder"
        : url;
    print(url0);

    Map<String, String> headers = {
      "X-RapidAPI-Key": "1d9649b6b2mshf5e531a70012aa3p10e8a7jsn36f9f5d8dd25",
      "X-RapidAPI-Host": "anime-db.p.rapidapi.com"
    };

    HTTP.Response response = await HTTP.get(Uri.parse(url0), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      List animeData = rawData['data'];
      List<AnimeDatabase> animes = animeData
          .map((e) => AnimeDatabase.fromJsonData(jsonData: e))
          .toList();
      return animes;
    } else {
      Fluttertoast.showToast(
          msg: "Database Not Found,Perhaps Some Error Occured !!");
      throw "Database Not Found,Perhaps Some Error Occured !!";
    }
  }
}
