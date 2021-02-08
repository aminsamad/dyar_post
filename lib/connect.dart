
import 'package:flutter/material.dart';

import 'models/contans.dart';

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: activeIconColor,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/anim3.gif")),
                color: Colors.white,
                shape: BoxShape.circle),
          ),
          SizedBox(height: 60),
          Center(
            child: Text("ئینته‌رنێتت نییه‌ !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                )),
          ),
          SizedBox(height: 60),
          Center(
            child: Text(
                "تكایه‌ مۆبایله‌كه‌ت په‌یوه‌ست بكه‌ به‌ هێڵی ئینته‌رنێته‌وه‌ پاشان دوباره‌كردنه‌وه‌ لێبده‌  ئه‌گه‌ر خه‌تت نه‌بیت هه‌مووكات ئه‌م په‌ره‌یه‌ ده‌كرێته‌وه‌",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                              primary:  Colors.orange, // background
                              textStyle:
                                  TextStyle(color: Color(0xfff5f5f5)), // foreground
                             shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                              ), child: Text('دوباره‌ كردنه‌وه'),
                          
                onPressed: () {},
              ),
              
            ),
          ),
          Text('')
        ],
      ),
    );
  }
}
