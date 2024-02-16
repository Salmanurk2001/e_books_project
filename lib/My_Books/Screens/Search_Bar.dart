
import 'package:e_books_project/My_Books/Screens/Loading_Books.dart';
import 'package:e_books_project/My_Books/Screens/Error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFilter extends StatefulWidget {
  var d;
  SearchFilter({@required this.d});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  var isbn;

  getisbn(int index) {
    try {
      setState(() {
        isbn = widget.d["items"][index + 1]["volumeInfo"]["industryIdentifiers"]
        [0]["identifier"];
      });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return error();
      }));
    }
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 20) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return ans + "...";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "RESULT",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "..",
                      // style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.d["items"].length - 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: (Container(
                        padding: EdgeInsets.all(10),
                        height: 270,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                opacity: 0.4,
                                image: AssetImage("assets/Icons/Icons8-Ios7-Science-Literature.512.png"),
                                fit: BoxFit.fill)),
                        child: Row(
                          children: [
                            Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.d["items"]
                                      [index + 1]["volumeInfo"]
                                      ["imageLinks"]["thumbnail"]),
                                      fit: BoxFit.fill
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Flexible(
                                  child: Text(
                                    // you can change it accordingly

                                    (widget.d["items"][index + 1]["volumeInfo"]
                                    ["title"])
                                        .length >
                                        20
                                        ? st(widget.d["items"][index + 1]
                                    ["volumeInfo"]["title"])
                                        : widget.d["items"][index + 1]
                                    ["volumeInfo"]["title"],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    (widget.d["items"][index + 1]["volumeInfo"]
                                    ["authors"][0])
                                        .length >
                                        20
                                        ? "by " +
                                        st(widget.d["items"][index + 1]
                                        ["volumeInfo"]["authors"][0])
                                        : "by " +
                                        widget.d["items"][index + 1]
                                        ["volumeInfo"]["authors"][0],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Page Count:- " +
                                      (widget.d["items"][index + 1]
                                      ["volumeInfo"]["pageCount"]
                                          .toString()),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    getisbn(index);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return Bookloading(c: isbn);
                                        }));
                                  },
                                  // color: Colors.black,
                                  child: Text(
                                    "DETAILS",
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
