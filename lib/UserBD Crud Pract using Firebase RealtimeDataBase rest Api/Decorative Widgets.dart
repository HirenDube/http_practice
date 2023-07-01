import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SnackBar CustomSnackBarMesej(
    {required String mesej, bool isError = false, bool isUpdate = false}) {
  Color snackbarColor = Colors.transparent;
  if (isError) {
    snackbarColor = Colors.red;
  } else if (isUpdate) {
    snackbarColor = Colors.blue;
  } else {snackbarColor = Colors.green;}

  return SnackBar(
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: snackbarColor,
                borderRadius: BorderRadius.circular(20)),
            // height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    mesej,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  // Divider(
                  //   indent: 50
                  //   ,
                  //   endIndent: 50
                  //   ,
                  // )
                  SvgPicture.asset(
                    'assets/svgDesign/pngegg.svg',
                    color: Colors.white,
                    fit: BoxFit.fill,
                    height: 30,
                    width: 300,
                  )
                ],
              ),
            )),
      ));
}
