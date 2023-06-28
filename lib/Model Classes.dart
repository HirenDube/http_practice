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

  factory ToDos.fromJsonData({required Map jsonData}) {
    return ToDos(
        userId: jsonData["userId"] as int ?? 0,
        id: jsonData["id"] as int ?? 0,
        title: jsonData["title"] ?? "No data here",
        completed: jsonData["completed"] as bool ?? false);
  }
}

class Photos {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  Photos({required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl});

  factory Photos.fromJsonData({required Map<dynamic, dynamic> jsonData}) {
    return Photos(
        albumId: jsonData["albumId"],
        id: jsonData["id"],
        title: jsonData["title"],
        url: jsonData["url"],
        thumbnailUrl: jsonData["thumbnailUrl"]);
  }
}

class Products {
  final int id, ratingCount;
  final double price, rating;
  final String title, description, category, image;

  Products({required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
    required this.rating,
    required this.ratingCount});

  factory Products.fromJsonData({required Map jsonData}) {
    // var temp =  Products(
    //     id: jsonData["id"] as int ?? 0,
    //     title: jsonData["title"] as String ?? "",
    //     image: jsonData['image'] as String ?? "",
    //     price: jsonData['price'] as double ?? 0,
    //     category: jsonData['category'] as String ?? "",
    //     description: jsonData['descripstion'] as String ?? "",
    //     rating: jsonData['rating']['rate'] as double ?? 0,
    //     ratingCount: jsonData['ratingCount']['count'] as int ?? 0);
    Map ratings = jsonData['rating'];
    var temp = Products(
        id: int.parse("${jsonData["id"]}") ?? 0,
        title: jsonData["title"] ?? "No data to show",
        image: jsonData['image'] ?? "No data to show",
        price: double.parse("${jsonData['price']}") ?? 0,
        category: jsonData['category'] ?? "No data to show",
        description: jsonData['description'] ?? "No data to show",
        rating: double.parse("${ratings['rate']}") ?? 0.0,
        ratingCount: int.parse("${ratings['count']}") ?? 0);

    return temp;
  }
}

class Posts {
  final int id, userId;
  final String title, body;

  Posts({required this.title,
    required this.body,
    required this.id,
    required this.userId});

  factory Posts.fromJsonData({required Map jsonData}) {
    return Posts(
        title: jsonData['title'],
        body: jsonData['body'],
        id: int.parse("${jsonData['id']}"),
        userId: int.parse("${jsonData['userId']}"));
  }
}

class Albums {
  final int id, userId;
  final String title;

  Albums({required this.id, required this.title, required this.userId});

  factory Albums.fromJsonData({required Map jsonData}) {
    return Albums(
        id: jsonData['id'],
        title: jsonData['title'],
        userId: jsonData['userId']);
  }
}

class Comments {
  final int id, postId;
  final String name, email, body;

  Comments({required this.name,
    required this.email,
    required this.body,
    required this.id,
    required this.postId});

  factory Comments.fromJsonData({required Map jsonData}) {
    return Comments(
        name: jsonData['name'],
        email: jsonData['email'],
        body: jsonData['body'],
        id: jsonData['id'],
        postId: jsonData['postId']);
  }
}

class Users {
  final int id;
  final String name,
      username,
      email,
      street,
      suite,
      city,
      zipcode,
      lat,
      lng,
      phone,
      website,
      companyName,
      catchPhrase,
      bs;

  Users({
    required this.phone,
    required this.website,
    required this.companyName,
    required this.catchPhrase,
    required this.bs,
    required this.id,
    required this.zipcode,
    required this.name,
    required this.lat,
    required this.city,
    required this.email,
    required this.username,
    required this.lng,
    required this.suite,
    required this.street,
  });

  factory Users.fromJsonData({required Map jsonData}) {
    Map address = jsonData['address'];
    Map company = jsonData['company'];
    Map geo = address['geo'];
    return Users(
        phone: jsonData['phone'],
        website: jsonData['website'],
        companyName: company['name'],
        catchPhrase: company['catchPhrase'],
        bs: company['bs'],
        id: int.parse("${jsonData['id']}"),
        zipcode: address['zipcode'],
        name: jsonData['name'],
        lat: geo['lat'],
        city: address['city'],
        email: jsonData['email'],
        username: jsonData['username'],
        lng: geo['lng'],
        suite: address['suite'],
        street: address['street']);
  }
}

class UnsplashWallpapers {
  final String full;
  final String small;
  final String download;
  final String thumb;

  UnsplashWallpapers({required this.thumb,
    required this.full,
    required this.small,
    required this.download});

  factory UnsplashWallpapers.fromJsonData({required Map jsonData}) {
    Map urls = jsonData['urls'];
    Map links = jsonData['links'];
    return UnsplashWallpapers(
        full: urls['full'] as String,
        small: urls['small'] as String,
        download: links['download'] as String,
        thumb: urls['thumb'] as String);
  }
}

class FakestoreapiUsers {
  final String email,
      username,
      password,
      phone,
      firstname,
      lastname,
      city,
      street,
      zipcode,
      lat,
      long;
  final int houseNumber, id, v;

  FakestoreapiUsers({
    required this.v,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.firstname,
    required this.lastname,
    required this.city,
    required this.street,
    required this.zipcode,
    required this.lat,
    required this.long,
    required this.houseNumber,
    required this.id,
  });

  factory FakestoreapiUsers.fromJsonData({required Map jsonData}) {
    Map address = jsonData['address'];
    Map geoLoaction = address['geolocation'];
    Map name = jsonData['name'];
    return FakestoreapiUsers(
        email: jsonData['email'],
        username: jsonData['username'],
        password: jsonData['password'],
        phone: jsonData['phone'],
        firstname: name['firstname'],
        lastname: name['lastname'],
        city: address['city'],
        street: address['street'],
        zipcode: address['zipcode'],
        lat: geoLoaction['lat'],
        long: geoLoaction['long'],
        houseNumber: address['number'],
        id: jsonData['id'],
        v: jsonData['__v']);
  }
}

class AnimeDatabase {
  final String title, image, malLink, decription, id, type;
  final List alternativeTitles, genres;
  final int ranking, noOfEpisode;

  AnimeDatabase({required this.type, required this.id,
    required this.title,
    required this.image,
    required this.malLink,
    required this.decription,
    required this.alternativeTitles,
    required this.genres,
    required this.ranking,
    required this.noOfEpisode});

  factory AnimeDatabase.fromJsonData({required Map jsonData}) {
    return AnimeDatabase(
        id: jsonData['_id'],
        title: jsonData['title'],
        image: jsonData['image'],
        malLink: jsonData['link'],
        decription: jsonData['synopsis'],
        alternativeTitles: jsonData['alternativeTitles'],
        genres: jsonData['genres'],
        ranking: jsonData['ranking'],
        noOfEpisode: jsonData['episodes'],
        type: jsonData['type']);
  }
}
