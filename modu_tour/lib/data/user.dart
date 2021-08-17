import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class User {
  String key;
  String id;
  String pw;
  String createTime;

  User(this.id, this.pw, this.createTime);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value['id'],
        pw = snapshot.value['pw'],
        createTime = snapshot.value['createTime'];

  toJson() => {
        'id': id,
        'pw': pw,
        'createTime': createTime,
      };
}
