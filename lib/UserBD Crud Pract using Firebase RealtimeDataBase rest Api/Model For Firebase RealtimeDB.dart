import 'dart:convert';

class FirebaseRealTimeDB {
  final String username, password, fullName;

  FirebaseRealTimeDB({
    required this.username,
    required this.password,
    required this.fullName,
  });

  static List<FirebaseRealTimeDB> firebaseFromJson(String encodedJson) =>
      List<FirebaseRealTimeDB>.from(jsonDecode(encodedJson)
          .map((decodedJson) =>
              FirebaseRealTimeDB.fromJson(jsonData: decodedJson))
          .toList());

  factory FirebaseRealTimeDB.fromJson({required Map jsonData}) {
    FirebaseRealTimeDB objectToBeReturned = FirebaseRealTimeDB(
      username: jsonData['username'] ?? "",
      password: jsonData['password'] ?? "",
      fullName: jsonData['fullName'] ?? "",
    );

    return objectToBeReturned;
  }

  static Map<String,dynamic> firebaseRealTimeDBToJson(
      {required FirebaseRealTimeDB modelClassObject}) {
    Map<String,dynamic> mapToBeReturned = {
      'fullName': modelClassObject.fullName,
      'password': modelClassObject.password,
      'username': modelClassObject.username,
    };
    return mapToBeReturned;
  }
}
