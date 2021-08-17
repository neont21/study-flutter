import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'signPage.dart';
import 'login.dart';
import 'mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<Database> initDatabase() async => openDatabase(
        join(await getDatabasesPath(), 'tour_database.db'),
        onCreate: (db, version) => db
            .execute('CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT,'
                'title TEXT, tel TEXT, zipcode TEXT, address TEXT, mapx NUMBER,'
                'mapy NUMBER, imagePath TEXT)'),
        version: 1,
      );

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-5559473432756141~4917472887');
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: '모두의 여행',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/sign': (context) => SignPage(),
        '/main': (context) => MainPage(database),
      },
    );
  }
}
