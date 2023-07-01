import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http_practice/HTTP%20Services.dart';

import 'package:http_practice/main.dart';

import 'Model Classes.dart';

class ProductsApiData extends StatefulWidget {
  const ProductsApiData({Key? key}) : super(key: key);

  @override
  State<ProductsApiData> createState() => _ProductsApiDataState();
}

class _ProductsApiDataState extends State<ProductsApiData> {
  Future<void> showNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        "Api Notifications", "My First Local Notifications",priority: Priority.max,importance: Importance.max);
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flanp.show(1, "Hello There !!",
        "You Just got your 1st local notification, have fun while enjoying the APIs",
        notificationDetails);
    print("notification released");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("ProductsApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForProducts(),
          builder: (context, snapData) {
            if (snapData.hasData) {
              List<Products> apiData = snapData.data!;
              return ListView.separated(
                itemCount: apiData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Scaffold(
                                    appBar: AppBar(
                                      title: Text(apiData[index].title),
                                    ),
                                    body: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              apiData[index].image,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.contain,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Chip(
                                                  label: Text(
                                                      "Rating : ${apiData[index]
                                                          .rating} / 5"),
                                                ),
                                                Chip(
                                                  label: Text(
                                                      "Reviews : ${apiData[index]
                                                          .ratingCount}"),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                Chip(
                                                    label: Text(
                                                        "Product ID : ${apiData[index]
                                                            .id}")),
                                                Chip(
                                                  label: Text(
                                                      "Price : ${apiData[index]
                                                          .price} Rs. Only"),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            Text(apiData[index].description)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            )),
                    title: Text(
                      apiData[index].title,
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 17,
                        ),
                        Image.network(
                          apiData[index].image,
                          height: 400,
                          width: 400,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Chip(
                            label: Text(
                                "Price : ${apiData[index].price} Rs. Only")),
                        SizedBox(
                          height: 17,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Chip(
                                label: Text(
                                    "Rating : ${apiData[index].rating} / 5")),
                            Chip(
                                label: Text(
                                    "Reviews : ${apiData[index].ratingCount}")),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
