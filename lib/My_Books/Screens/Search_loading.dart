import 'dart:convert';
import 'package:GBook_App/My_Books/Screens/Search_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class SearchLoading extends StatefulWidget {
  var text;
  SearchLoading({@required this.text});

  @override
  State<SearchLoading> createState() => _SearchLoadingState();
}

class _SearchLoadingState extends State<SearchLoading> {
  var cp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    Response r = await get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyATedh8GPJrfcEcaZ5i8ZOo5wJuFIwFx1Y"),
    );

    cp = jsonDecode(r.body);
    print(cp);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchFilter(d: cp);
    }));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        // ignore: prefer_const_constructors
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ));
  }
}
