import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  _save(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File('${directory.path}/save.txt');
    await file.writeAsString(text);
  }

  _save2(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File('${directory.path}/save2.txt');
    await file.writeAsString(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/icon.png',
                    height: 90,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Dyar Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'خێرایی لە گواستنەوە',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(height: 100),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0)),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 30),
                        Container(
                            height: 70,
                            padding: EdgeInsets.all(12),
                            child: Container(
                              color: Color(0XFFF5F5F5),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return '! تکایە ئیمەیڵێک بنووسە';
                                  }
                                },
                                onSaved: (input) => _email = input,
                                cursorColor: Color(0XFFF5F5F5),
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    hintText: ' Email',
                                    focusColor: null,
                                    hintStyle: TextStyle(
                                        fontFamily: 'hhh',
                                        fontSize: 16,
                                        color: Color(0XFFB1B1B1))),
                              ),
                            )),
                        SizedBox(height: 5),
                        Container(
                            height: 70,
                            padding: EdgeInsets.all(12),
                            child: Container(
                              color: Color(0XFFF5F5F5),
                              child: TextFormField(
                                onSaved: (input) => _password = input,
                                obscureText: true,
                                cursorColor: Color(0XFFF5F5F5),
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    hintText: ' Password',
                                    focusColor: null,
                                    hintStyle: TextStyle(
                                        fontFamily: 'hhh',
                                        fontSize: 16,
                                        color: Color(0XFFB1B1B1))),
                              ),
                            )),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange, // background
                              textStyle:
                                  TextStyle(color: Colors.white), // foreground
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: signIn,
                            child: Text('چونەژوورەوە'),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () => displayBottomSheet(
                                    context, 'ئەکاونتت نیە ؟'),
                                child: Text(
                                  'ئەکاونتت نیە ؟',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                )),
                            TextButton(
                                onPressed: () => displayBottomSheet(
                                    context, 'وشەی نهێنیت بیرچووە ؟'),
                                child: Text(
                                  'وشەی نهێنیت بیرچووە ؟',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                )),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        _save(_email);
        _save2(_password);
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        Toast.show(
            "ببوورە، تکایە دڵنیابەرەوە لە ئیمەیڵ یان وشەی نهێنی", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}

void displayBottomSheet(
  BuildContext context,
  String a,
) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        a,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 400,
                        height: 1,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Image.asset(
                        'assets/icon.png',
                        height: 90,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'تکایە بەڕێوبەر ئاگادار بکەوە پەیوەندی پێوە بکە لە ڕێگای ژمارە تەلەفۆنەوە یاخود لە فەیسبووک نامەمان بۆ بنێرە.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            textStyle:
                                TextStyle(color: Colors.white), // foreground
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () => launch("tel://07702675762"),
                          child: Text('پەیوەندەی'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[800], // background
                            textStyle:
                                TextStyle(color: Colors.white), // foreground
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            _launchURL();
                          },
                          child: Text('فەیسبووک'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      });
}

_launchURL() async {
  const url = 'https://www.facebook.com/dyar.work.q';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 