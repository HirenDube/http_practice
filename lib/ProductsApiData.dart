import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class ProductsApiData extends StatefulWidget {
  const ProductsApiData({Key? key}) : super(key: key);

  @override
  State<ProductsApiData> createState() => _ProductsApiDataState();
}

class _ProductsApiDataState extends State<ProductsApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
