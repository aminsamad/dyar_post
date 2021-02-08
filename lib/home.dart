import 'dart:async';
import 'dart:io';

import 'package:dyar_post/connect.dart';
import 'package:dyar_post/login/login.dart';
import 'package:dyar_post/tabs/about.dart';
import 'package:dyar_post/tabs/all.dart';
import 'package:dyar_post/tabs/filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  const Home({Key key, this.user}) : super(key: key);
  final UserCredential user;
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        title = 'سەرەتا';
      } else {
        if (_selectedIndex == 1) {
          title = 'گەیشتوو';
        } else {
          if (_selectedIndex == 2) {
            title = 'نەگەیشتوو';
          } else {
            if (_selectedIndex == 3) {
              title = 'دەربارە';
            } else {}
          }
        }
      }
    });
  }

  Future<void> _cnc() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConnectPage()));
    }
  }
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
  List<Shop> itemsShop;
  Shop itemShop;
  DatabaseReference itemRefShop;
  final databaseReference = FirebaseDatabase.instance.reference();

  String userd;
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
    _cnc();
  }

  String title = 'سەرەتا';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(title),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            tooltip: "مینوو",
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                  child: TextButton(
                    child: Text(
                      "نوێكردنه‌وه‌",
                    ),
                    onPressed: () {},
                  ),
                  value: "/نوێكردنه‌وه‌"),
              PopupMenuItem(
                  child: TextButton(
                    child: Text(
                      "په‌یوه‌ندی",
                    ),
                    onPressed: () {
                      _selectedIndex = 4;
                    },
                  ),
                  value: "/په‌یوه‌ندی"),
              PopupMenuItem(
                  child: TextButton(
                    child: Text(
                      "داخستنی ئه‌كاونت",
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                  value: "/داخستنی ئه‌كاونت"),
              PopupMenuItem(
                  child: TextButton(
                    child: Text(
                      "ده‌رچوون",
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  value: "/ده‌رچوون"),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: [
          ListCard(),
          Filter('true'),
          Filter('false'),
          AboutPage()
        ]),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home_outlined),
            label: 'سەرەتا',
          ),
          new BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/gaishtw.png',
              height: 30,
              color: Color(0xFF737373),
            ),
            activeIcon: new Image.asset('assets/gaishtw.png',
                height: 30, color: Colors.orange),
            label: 'گەیشتوو',
          ),
          new BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/nagaishtw.png',
              height: 30,
              color: Color(0xFF737373),
            ),
            label: 'نەگەیشتوو',
            activeIcon: new Image.asset('assets/nagaishtw.png',
                height: 30, color: Colors.orange),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.person_outline),
            label: 'دەربارە',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}


class Shop {
  String uid;
  String gashtu;
  String itemname;
  String kat;
  String key;
  String nagashtu;
  String nrx;
  String sarder;
  String shwen;
  String tzhmara;
  String zhkabra;

  Shop(
    this.uid,
    this.gashtu,
    this.itemname,
    this.kat,
    this.key,
    this.nagashtu,
    this.nrx,
    this.sarder,
    this.shwen,
    this.tzhmara,
    this.zhkabra,
  );

  Shop.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        uid = snapshot.value["uid"],
        gashtu = snapshot.value["gashtu"],
        itemname = snapshot.value["item_name"],
        kat = snapshot.value["kat"],
        nagashtu = snapshot.value["nagashtu"],
        nrx = snapshot.value["nrx"],
        sarder = snapshot.value["sarder"],
        shwen = snapshot.value["shwen"],
        tzhmara = snapshot.value["t_zhmara"],
        zhkabra = snapshot.value["zh_kabra"];

  toJson() {
    return {
      "uid": uid,
      "gashtu": gashtu,
      "item_name": itemname,
      "kat": kat,
      "nagashtu": nagashtu,
      "nrx": nrx,
      "sarder": sarder,
      "shwen": shwen,
      "t_zhmara": tzhmara,
      "zh_kabra": zhkabra,
    };
  }
}
