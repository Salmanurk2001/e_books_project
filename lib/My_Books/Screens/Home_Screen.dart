import 'package:e_books_project/My_Books/Category/self_guide.dart';
import 'package:e_books_project/My_Books/Category/Novel.dart';
import 'package:e_books_project/My_Books/Category/Science.dart';
import 'package:e_books_project/My_Books/Category/Romance.dart';
import 'package:e_books_project/My_Books/Category/Fantasy.dart';
import 'package:e_books_project/My_Books/Screens/Search_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  var c1;
  var c2;
  var c3;
  var c4;
  var c5;
  HomeScreen(
      {@required this.c1,
        @required this.c2,
        @required this.c3,
        @required this.c4,
        @required this.c5
      });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController t = TextEditingController();

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 3) {
        break;
      }
      if (s[i] == ' ') {
        count++;
      }
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.c1);
  }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
              child: Column(
                children: [
                  Container(
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            }),
                            child:
                            Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              height: 40,
                              child: TextField(
                                controller: t,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Search Book...",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(40))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SearchLoading(text: t.text);
                                  }));
                            },
                            child: Text(
                              "SEARCH",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                      child:
                      DefaultTabController(
                      length: 4,
                      child: NestedScrollView(
                        headerSliverBuilder: (context, value) {
                          return [
                            SliverAppBar(
                              backgroundColor: Colors.black,
                              bottom: TabBar(
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.red,
                                  tabs: [
                                    Tab(text: 'Novel',),
                                    Tab(text: 'Science',),
                                    Tab(text: 'Fantasy',),
                                    Tab(text: 'Romance',)]
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          children: [
                            Novel(c1: widget.c1),
                            Science(c2: widget.c2),
                            Fantasy(c3: widget.c3),
                            Romance(c4: widget.c4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Self Guide",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                                Icon(Icons.arrow_forward,color: Colors.white)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Self_Guide(c5: widget.c5),
                        ],
                      )
                  )
                ],
              )
          ),
       ));
    }
}
