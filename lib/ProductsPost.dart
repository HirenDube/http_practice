import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_practice/HTTP%20Services.dart';

import 'Model Classes.dart';

class ProductsPost extends StatefulWidget {
  const ProductsPost({Key? key}) : super(key: key);

  @override
  State<ProductsPost> createState() => _ProductsPostState();
}

class _ProductsPostState extends State<ProductsPost> {
  String mesej = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ProductsPost"),
        ),
        body: Center(
          child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () async {
                String ads = await HTTPServices.postDataForProducts(dataBody: Products.productstoJson(object: Products(id: 0,
                    title: "title",
                    image: "image",
                    price: 22.23,
                    category: "category",
                    description: "description",
                    rating: 20.25,
                    ratingCount: 1500)));
                setState(() {
                  mesej = ads;
                });
              }, child: Text("Add Data")), Text(mesej,style: TextStyle(fontSize: 30),)
            ],
          ),
        ));
  }
}
