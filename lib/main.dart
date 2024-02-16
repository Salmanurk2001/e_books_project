
import 'package:e_books_project/My_Books/Screens/Spalsh_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Book Reading",
          home: SplashScreen(),
        )
    );
  }
}
