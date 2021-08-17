import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'memo.dart';
import 'memoAdd.dart';
import 'memoDetail.dart';

class MemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemoPage();
}

class _MemoPage extends State<MemoPage> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL = 'https://example-7ea38-default-rtdb.firebaseio.com';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Memo> memos = List();

  BannerAd bannerAd = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    listener: (MobileAdEvent event) {
      print('$event');
    },
  );

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-5559473432756141~1819562480');
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('memo');

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });

    _firebaseMessaging.getToken().then((value) => print(value));
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok'),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );

    bannerAd
      ..load()
      ..show(anchorOffset: 0, anchorType: AnchorType.bottom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {
                                Memo memo = await Navigator.of(context).push(
                                    MaterialPageRoute<Memo>(
                                        builder: (BuildContext context) =>
                                            MemoDetailPage(
                                                reference, memos[index])));
                                if (memo != null) {
                                  setState(() {
                                    memos[index].title = memo.title;
                                    memos[index].content = memo.content;
                                  });
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(memos[index].title),
                                        content: Text('삭제하시겠습니까?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              reference
                                                  .child(memos[index].key)
                                                  .remove()
                                                  .then((_) {
                                                setState(() {
                                                  memos.removeAt(index);
                                                  Navigator.of(context).pop();
                                                });
                                              });
                                            },
                                            child: Text('예'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니요'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text(memos[index].content),
                            ),
                          ),
                        ),
                        header: Text(memos[index].title),
                        footer: Text(memos[index].createTime.substring(0, 10)),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MemoAddPage(reference)));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
