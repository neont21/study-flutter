import 'package:flutter/material.dart';

class SecondDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondDetail();
}

class _SecondDetail extends State<SecondDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            RaisedButton(
              onPressed: () {
                if (controller.value.text != "") {
                  Navigator.of(context).pop(controller.value.text);
                }
              },
              child: Text('저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}
