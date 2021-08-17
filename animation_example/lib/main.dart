import 'package:flutter/material.dart';
import 'people.dart';
import 'secondPage.dart';
import 'intro.dart';
import 'sliverPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp> {
  List<People> people = new List();
  Color weightColor = Colors.blue;
  int current = 0;
  double _opacity = 1;

  @override
  void initState() {
    people.add(People('스미스', 180, 92));
    people.add(People('메리', 162, 55));
    people.add(People('존', 177, 75));
    people.add(People('바트', 130, 40));
    people.add(People('콘', 194, 140));
    people.add(People('디디', 100, 80));
    people.add(People('피터', 159, 52));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: SizedBox(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text('이름: ${people[current].name}'),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        child: Text(
                          '키 ${people[current].height}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: people[current].height,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        child: Text(
                          '몸무게 ${people[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: people[current].weight,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        child: Text(
                          'bmi ${people[current].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: people[current].bmi,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  height: 200,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (current < people.length - 1) {
                      current++;
                    }
                    _changeWeightColor(people[current].weight);
                  });
                },
                child: Text('다음'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (current > 0) {
                      current--;
                    }
                    _changeWeightColor(people[current].weight);
                  });
                },
                child: Text('이전'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _opacity == 1 ? _opacity = 0 : _opacity = 1;
                  });
                },
                child: Text('사라지기'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
                child: SizedBox(
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: 'detail',
                        child: Icon(Icons.cake),
                      ),
                      Text('이동하기')
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SliverPage()));
                },
                child: Text('페이지 이동'),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
