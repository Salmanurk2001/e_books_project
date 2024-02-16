

import 'dart:convert';


import 'package:e_books_project/My_Books/Screens/Display_book.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class Bookloading extends StatefulWidget {
  var c;
  Bookloading({@required this.c});

  @override
  State<Bookloading> createState() => _BookloadingState();
}

class _BookloadingState extends State<Bookloading> {
  var c2;

  @override
  void initState() {
    print(widget.c);
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    try {
      Response r = await get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=isbn:${widget.c}&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"));
      c2 = jsonDecode(r.body);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Bookdisplay(d: c2);
      }));
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
