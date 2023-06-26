import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as HTTP;

import 'Model Classes.dart';

class HTTPServices {
  static Future<List<ToDos>> getDataForToDos(
      {String url = "https://jsonplaceholder.typicode.com/todos"}) async {
    HTTP.Response response = await HTTP.get(
      Uri.https("jsonplaceholder.typicode.com", "todos"),
    );
    if (response.statusCode == 200) {
      List<dynamic> convertedData = jsonDecode(response.body);
      List<ToDos> convertedDataToBeUsed =
          convertedData.map((data) => ToDos.fromJson(data)).toList();
      print(convertedDataToBeUsed);
      print(convertedDataToBeUsed[0]);
      print(convertedDataToBeUsed[100].title);
      return convertedDataToBeUsed;
    } else {
      print("No data got!!");
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
      List<Photos> convertedDataToBeUsed =
          convertedData.map((data) => Photos.fromRawData(data)).toList();
      print(convertedDataToBeUsed);
      print(convertedDataToBeUsed[0]);
      print(convertedDataToBeUsed[100].title);
      return convertedDataToBeUsed;
    } else {
      print("No data got!!");
      Fluttertoast.showToast(msg: "No data to fetch !!");
      throw "No data got!!";
    }
  }
}
