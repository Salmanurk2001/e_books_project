
import 'dart:io' as i;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookdisplay extends StatefulWidget {
  var d;
  Bookdisplay({@required this.d});

  @override
  State<Bookdisplay> createState() => _BookdisplayState();
}

class _BookdisplayState extends State<Bookdisplay> {
  var desc = "Not available";
  var url =
  "https://www.bing.com/images/search?view=detailV2&ccid=vx9%2fIUj5&id=3B7650A146D55682645F765E60E786419299154C&thid=OIP.vx9_IUj50utS7cbaiRtoZAHaE8&mediaurl=https%3a%2f%2fst3.depositphotos.com%2f1186248%2f14351%2fi%2f950%2fdepositphotos_143511907-stock-photo-not-available-rubber-stamp.jpg&exph=682&expw=1023&q=not+available&simid=608054098357136066&FORM=IRPRST&ck=BADF0353AC59677CCFAA67227357E3CB&selectedIndex=1&ajaxhist=0&ajaxserp=0";

  @override
  void initState() {
    // TODO: implement initState
    print(widget.d);
    super.initState();
    getdesc();
    geturl();
  }

  geturl() {
    try {
      url = widget.d["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      url = widget.d["items"][1]["volumeInfo"]["imageLinks"]["thumbnail"];
    }
  }

  void getdesc() {
    try {
      setState(() {
        desc = widget.d["items"][0]["volumeInfo"]["description"];
      });
    } catch (e) {
      setState(() {
        desc = "Not available";
      });
    }
  }
  Future openfile(var url, var title) async {
    final file = await downloadfile(url, title!);
    if (file == null) {
      print("null");
      return;
    }
    print(file.path);
    OpenFile.open(file.path);
  }

  Future<i.File?> downloadfile(var url, var filename) async {
    try {
      var appstorage = await getApplicationDocumentsDirectory();
      final file = i.File('${appstorage.path}/filename');
      final Response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));
      final raf = file.openSync(mode: i.FileMode.write);
      raf.writeFromSync(Response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: ElevatedButton(
          onPressed: () async {
            await launchUrl(
                Uri.parse(widget.d["items"][0]["accessInfo"]["webReaderLink"]));
          },
          child: Text(
            "READ BOOK",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                        size: 30,
                      ),
                    ),
                     Text(
                      "DETAILS",
                      style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold,)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          var url = widget.d["items"][0]["accessInfo"]["epub"]
                          ["isAvailable"];
                          if (url == true) {
                            url = widget.d["items"][0]["accessInfo"]["epub"]
                            ["acsTokenLink"];
                            await launchUrl(Uri.parse(url));
                          }
                        } catch (e) {
                          print("Not available");
                        }
                      },
                      child: Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.4,
                          image: AssetImage("assets/Icons/Itzikgur-My-Seven-Books-1.512.png"),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 230,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  url,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.d["items"][0]["volumeInfo"]["title"],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "by " +
                              widget.d["items"][0]["volumeInfo"]["authors"][0],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15, color: Colors.grey[200])),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 25),
                            child: ListView(
                              children: [
                                Text(
                                  "What's it about?",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  desc,
                                  style: GoogleFonts.lato(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}

