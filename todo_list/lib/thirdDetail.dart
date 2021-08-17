import 'package:flutter/material.dart';

class ThirdDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThirdDetail();
}

class _ThirdDetail extends State<ThirdDetail> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Container(
        child: Center(
          child: Text(
            args,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
