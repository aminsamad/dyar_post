import 'dart:io';

import 'package:dyar_post/models/contans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListCard extends StatefulWidget {
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  String uid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final User user = auth.currentUser;
    uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  String textt;
  Future<String> _read() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/save.txt');
      textt = await file.readAsString();
    } catch (e) {}

    return textt;
  }

  FirebaseAuth user;
  DatabaseReference itemRefShop;
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    inputData();
    FirebaseAuth.instance.authStateChanges().listen((User userb) {
      if (userb == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userd = userb.toString();
        });
      }
    });
    _read();
  }

  String userd;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: Colors.white,
            height: 550,
            child: new SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: 550,
                child: new StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .reference()
                        .child('post')
                        .orderByChild('uid')
                        .equalTo(uid)
                        .onValue,
                    builder:
                        (BuildContext context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.snapshot.value != null) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          List<dynamic> list = map.values.toList();
                          return new ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(children: [
                                  InkWell(
                                    onTap: () =>
                                      _show(
                                          context,
                                          list[index]['sarder'],
                                          list[index]['item_name'],
                                          list[index]['t_zhmara'],
                                          list[index]['kat'],
                                          list[index]['nrx'],
                                          list[index]['shwen'],
                                          list[index]['zh_kabra']),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffE0E0E0)),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 2),
                                                blurRadius: 1,
                                                color: Colors.grey[300]),
                                          ],
                                        ),
                                        child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Color(0xffe0e0e0),
                                              onTap: null,
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Color(0xffff8f00),
                                                              Color(0xffffb300)
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Row(children: <
                                                          Widget>[
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                              onPressed: null,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              splashColor: Color(
                                                                  0xffe0e0e0),
                                                              icon: Icon(
                                                                  Icons.sort,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              list[index]
                                                                  ['sarder'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ))
                                                      ])),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    list[index]['item_name'],
                                                    style: TextStyle(
                                                      color: Color(0xff616161),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color: activeIconColor),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 8,
                                                            right: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/clock.png",
                                                          color:
                                                              bottomNavIconColor,
                                                          height: 18,
                                                          width: 18,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          list[index]['kat'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor),
                                                        ),
                                                        Expanded(
                                                            child: SizedBox()),
                                                        Text(
                                                          list[index]
                                                              ['t_zhmara'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Image.asset(
                                                          "assets/taxi.png",
                                                          color:
                                                              bottomNavIconColor,
                                                          height: 18,
                                                          width: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color: activeIconColor),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 8,
                                                            right: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/location.png",
                                                          color:
                                                              bottomNavIconColor,
                                                          height: 18,
                                                          width: 18,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          list[index]['shwen'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor),
                                                        ),
                                                        Expanded(
                                                            child: SizedBox()),
                                                        Text(
                                                          list[index]['nrx'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Image.asset(
                                                          "assets/money.png",
                                                          color:
                                                              bottomNavIconColor,
                                                          height: 18,
                                                          width: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color: activeIconColor),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 8,
                                                            right: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Text(
                                                          list[index]
                                                              ['zh_kabra'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Image.asset(
                                                          "assets/call.png",
                                                          color:
                                                              bottomNavIconColor,
                                                          height: 18,
                                                          width: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                  )
                                ]);
                              });
                        }
                      }
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
              ),
            )));
  }
}

_show(BuildContext context, String gaishtu, String item, String teksi,
    String date, String nrx, String shwen, String call) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Icon(Icons.arrow_upward),
                SizedBox(height: 10),
                Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    color: Color(0xffffffff),
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffff8f00),
                                  Color(0xffffb300)
                                ]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              gaishtu,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Icon(
                                Icons.list_alt,
                                color: bottomNavIconColor,
                                size: 18,
                              ),
                              SizedBox(width: 3),
                              Text(": ناوی كاڵا",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              SizedBox(width: 10),
                              Text(
                                item,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 1,
                            color: activeIconColor,
                            width: double.infinity),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Image.asset("assets/taxi.png",
                                  height: 18,
                                  width: 18,
                                  color: bottomNavIconColor),
                              SizedBox(width: 3),
                              Text(":  ژ.ته‌كسی",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              SizedBox(width: 10),
                              Text(
                                teksi,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 1,
                            color: activeIconColor,
                            width: double.infinity),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Image.asset("assets/clock.png",
                                  height: 18,
                                  width: 18,
                                  color: bottomNavIconColor),
                              SizedBox(width: 3),
                              Text(":  به‌روار",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              SizedBox(width: 10),
                              Text(
                                date,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 1,
                            color: activeIconColor,
                            width: double.infinity),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Image.asset("assets/money.png",
                                  height: 18,
                                  width: 18,
                                  color: bottomNavIconColor),
                              SizedBox(width: 3),
                              Text(": نرخ",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              SizedBox(width: 10),
                              Text(
                                nrx,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 1,
                            color: activeIconColor,
                            width: double.infinity),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Image.asset("assets/location.png",
                                  height: 18,
                                  width: 18,
                                  color: bottomNavIconColor),
                              SizedBox(width: 3),
                              Text(": شوێن",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              Text(
                                shwen,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 1,
                            color: activeIconColor,
                            width: double.infinity),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Image.asset("assets/call.png",
                                  height: 18,
                                  width: 18,
                                  color: bottomNavIconColor),
                              SizedBox(width: 3),
                              Text(": ژ.وه‌رگر",
                                  style: TextStyle(
                                      color: bottomNavIconColor, fontSize: 16)),
                              SizedBox(width: 10),
                              Text(
                                call,
                                style: TextStyle(
                                    color: Color(0xff616161), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ));
      });
}
