

import 'dart:convert';
import 'package:GBook_App/My_Books/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  var l;
  LoadingScreen({@required this.l});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController c;
  var c1;
  var c2;
  var c3;
  var c4;
  var c5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategorydata();

  }

  void getcategorydata() async {
    Response r1 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:novel&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
    Response r2 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:science&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
    Response r3 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
    Response r4 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:romance&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
    Response r5 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:self-guide&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
    c1 = jsonDecode(r1.body);
    c2 = jsonDecode(r2.body);
    c3 = jsonDecode(r3.body);
    c4 = jsonDecode(r4.body);
    c5 = jsonDecode(r5.body);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(c1: c1, c2: c2, c3: c3, c4: c4, c5: c5);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:CircularProgressIndicator(
                  color: Colors.black,
                )
            )
          ],
        ),
      ),
    ));
  }
}
