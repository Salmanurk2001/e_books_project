import 'package:e_books_project/My_Books/Screens/Loading_Books.dart';
import 'package:e_books_project/My_Books/Screens/Error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Self_Guide extends StatefulWidget {
  var c5;
  Self_Guide({@required this.c5});

  @override
  State<Self_Guide> createState() => _Self_GuideState();
}

class _Self_GuideState extends State<Self_Guide> {
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
  Widget build(BuildContext context) {
    return (Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          itemBuilder: (context, index) {
            return (Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              try {
                                return Bookloading(
                                    c: widget.c5["items"][index + 1]["volumeInfo"]
                                    ["industryIdentifiers"][0]["identifier"]);
                              } catch (e) {
                                return error();
                              }
                            }));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 230,
                            width: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(widget.c5["items"]
                                  [index + 1]["volumeInfo"]
                                  ["imageLinks"]["thumbnail"]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (widget.c5["items"][index + 1]["volumeInfo"]
                            ["title"])
                                .length >
                                20
                                ? st(widget.c5["items"][index + 1]["volumeInfo"]
                            ["title"])
                                : widget.c5["items"][index + 1]["volumeInfo"]
                            ["title"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          }),
    ));
  }
}
