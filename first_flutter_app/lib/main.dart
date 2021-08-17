import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // step 01: `createState`
  @override
  State<StatefulWidget> createState() {
    print('createState');
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  // var switchValue = false;
  String test = 'hello';
  Color _color = Colors.blue;

  // step 05 `build`
  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.light(),
        home: Scaffold(
          body: Center(
              child: RaisedButton(
                  child: Text('$test'),
                  color: _color,
                  onPressed: () {
                    if (_color == Colors.blue) {
                      setState(() {
                        test = 'flutter';
                        _color = Colors.amber;
                      });
                    } else {
                      setState(() {
                        test = 'hello';
                        _color = Colors.blue;
                      });
                    }
                  })),
        ));
  }

  // step 03: `initState`
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  // step 04: `didChangeDependencies`
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}
