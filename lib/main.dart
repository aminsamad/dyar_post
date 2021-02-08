import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statusbar/statusbar.dart';
import 'package:your_splash/your_splash.dart';

import 'home.dart';
import 'login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Dyar Post',
      options: const FirebaseOptions(
          appId: '1:157023286872:android:c9c68ea1c9db455b477c2d',
          apiKey: 'AIzaSyCEsDUQI-NRYKJiRAlj7A5TcOJWM3ahYpA',
          messagingSenderId: '157023286872',
          projectId: 'dyar-post'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dyar Post',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'rudaw',
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen.timed(
          route: MaterialPageRoute(builder: (_) => MyHomePage()),
          seconds: 4,
          body: Scaffold(
            backgroundColor: Colors.orange,
            body: Center(
              child: Container(
                  height: 125,
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/icon.png',
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  )),
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    StatusBar.color(Colors.orange);
      setState(() {
      _save();
    _save2();
    });
  }

  String save;
  Future<String> _save() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/save.txt');
      save = await file.readAsString();
    } catch (e) {}

    return save;
  }

  String save2;
  Future<String> _save2() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/save2.txt');
      save2 = await file.readAsString();
    } catch (e) {}

    return save2;
  }
String ch = 'no';
  @override
  Widget build(BuildContext context) {
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
     ch = 'no';
    } else {
      setState(() {
       ch = 'yes';
     });
    }
  });
   
    if (ch == 'no')
      return Login();
    else

    return Home();
  }

}

UserCredential userr;
