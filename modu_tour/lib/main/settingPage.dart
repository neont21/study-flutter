import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference databaseReference;
  final String id;

  SettingPage({this.databaseReference, this.id});

  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool pushCheck = true;
  BannerAd bannerAd = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    listener: (MobileAdEvent event) => print('$event')
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
    bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    bannerAd
    ..load()
    ..show(
      anchorOffset: 60,
      anchorType: AnchorType.bottom,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('설정하기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '푸시 알림',
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value: pushCheck,
                      onChanged: (value) {
                        setState(() {
                          pushCheck = value;
                        });
                        _setData(value);
                      }),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Text(
                  '로그아웃',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  AlertDialog dialog = AlertDialog(
                    title: Text('아이디 삭제'),
                    content: Text('아이디를 삭제하시겠습니까?'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          print(widget.id);
                          widget.databaseReference
                              .child('user')
                              .child(widget.id)
                              .remove();
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        },
                        child: Text('예'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오'),
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => dialog);
                },
                child: Text(
                  '회원 탈퇴',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          pushCheck = true;
        });
      } else {
        setState(() {
          pushCheck = value;
        });
      }
    });
  }
}
