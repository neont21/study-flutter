import 'package:firebase_example/tabsPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'memoPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MemoPage(),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  FirebaseApp({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'hello flutter',
        'int': 100,
      },
    );
    setMessage('Analytics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('테스트'),
              onPressed: _sendAnalyticsEvent,
            ),
            Text(
              _message,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon((Icons.tab)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<TabsPage>(
              settings: RouteSettings(name: '/tab'),
              builder: (BuildContext context) {
                return TabsPage(observer);
              }));
        },
      ),
    );
  }
}
