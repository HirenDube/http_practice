import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as fromNet;
import 'package:http_practice/UserBD%20Crud%20Pract%20using%20Firebase%20RealtimeDataBase%20rest%20Api/Model%20For%20Firebase%20RealtimeDB.dart';

class ServiceProvider {
  static Future<List> getAllData() async {
    String link = "https://fir-a-to-z-default-rtdb.firebaseio.com/users.json";
    Uri url = Uri.parse(link);

    fromNet.Response res = await fromNet.get(url);
    log("${res.statusCode == 200 ? "Data fetched Successfully" : "!! Didn't got the data , perhaps due to some sort of error !!"}");
    if (res.statusCode == 200) {
      List answer = FirebaseRealTimeDB.firebaseFromJson(res.body);
      return answer;
    } else {
      Fluttertoast.showToast(msg: "!! Data can't be fetched !!");
      throw "!! Data can't be fetched !!";
    }
  }
}
