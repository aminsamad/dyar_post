import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dyar_post/models/contans.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //appbar
      height: 800,
      child: Stack(
        children: <Widget>[
          Container(
            height: 210,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/kindpng_2620644.png")),
              color: activeIconColor,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150),

                  //GridView
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          //widgets
                          Container(
                              height: 270,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffbdbdbd), blurRadius: 10)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Image.asset("assets/icon.png", height: 70),
                                  SizedBox(height: 10),
                                  Text(
                                    "Dyar Post",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text("07702675762",
                                      style:
                                          TextStyle(color: Color(0xff9e9e9e))),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      //facebook
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                customLaunch(
                                                    "https://www.facebook.com/dyar.work.q/");
                                              },
                                              child: Image.asset(
                                                "assets/facebook1.png",
                                                height: 25,
                                                width: 25,
                                                color: bottomNavIconColor,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "فه‌یسبووك",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF969696),
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: 60,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            color: bottomNavIconColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      //zh_talaphone
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                customLaunch("tel:07702675762");
                                              },
                                              child: Image.asset(
                                                "assets/call.png",
                                                height: 25,
                                                width: 25,
                                                color: bottomNavIconColor,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "ژماره‌ ته‌له‌فۆن",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF969696),
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: 60,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            color: bottomNavIconColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      //website
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                customLaunch(
                                                    "http://www.dyarpost.cf");
                                              },
                                              child: Image.asset(
                                                "assets/globe.png",
                                                height: 25,
                                                width: 25,
                                                color: bottomNavIconColor,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "وێبسایت",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF969696),
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: 30),
                          ColorizeAnimatedTextKit(
                            text: [
                              "خێرایی له‌ گواستنه‌وه‌",
                            ],
                            textStyle: TextStyle(fontSize: 25.0),
                            colors: [
                              activeIconColor,
                              Color(0xFFFFD900),
                              Color(0xFFFF5E00),
                              Colors.red,
                            ],
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Card(
                            color: activeIconColor,
                            child: Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: double.infinity,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/anim2.gif")),
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    throw "can launch $command";
  }
}
