import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock By MrCK',
      home: Clock(),
    );
  }
}

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  final f = DateFormat('hh : mm a');


  @override
  void initState() {
    // print();
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: Center(
          child: Text(
            'Clock',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepOrange,
        child: Center(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Material(
                elevation: 30,
                color: Colors.brown.shade800,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 300,
                  child: Center(
                    child: Text(
                      f.format(DateTime.now()),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.rotationZ(animation.value),
              alignment: FractionalOffset(0.5, 0.1),
              child: Container(
                child: Image.asset(
                  'images/pandulum.png',
                  width: 100,
                  height: 250,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
