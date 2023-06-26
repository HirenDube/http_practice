class ToDos {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  ToDos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ToDos.fromJson(Map data) {
    return ToDos(
        userId: data["userId"] as int ?? 0,
        id: data["id"] as int ?? 0,
        title: data["title"] ?? "No data here",
        completed: data["completed"] as bool ?? false);
  }
}

class Photos {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  Photos(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photos.fromRawData(Map<dynamic, dynamic> rawData) {
    return Photos(
        albumId: rawData["albumId"],
        id: rawData["id"],
        title: rawData["title"],
        url: rawData["url"],
        thumbnailUrl: rawData["thumbnailUrl"]);
  }
}
