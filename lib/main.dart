import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/welcome': (context) => WelcomeScreen(),
      },

      title: 'Flutter SignUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(

        ),
        body: flu(),
      ),
    );
  }
}

class flu extends StatefulWidget {
  @override
  _fluState createState() => _fluState();
}

class _fluState extends State<flu> with SingleTickerProviderStateMixin {

  Animation<double> _sizeAnimation;
 // Animation<Color> _colorAnimation;
  AnimationController _controller;

  CurvedAnimation _curve;

  void showWelcomeScreen(){
      Navigator.of(context).pushNamed('/welcome');
  }

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    this._curve = CurvedAnimation(parent:
    this._controller, curve: Curves.easeInCubic);
    this._sizeAnimation =
        Tween<double>(begin: 50, end: 200).animate(this._curve);
    // this._colorAnimation =
    //     ColorTween(begin: Colors.transparent, end: Colors.red).animate(
    //         this._curve);

    this._controller.addListener(() => setState(() {

    }));


  }

  @override void dispose() {
    super.dispose();
    this._controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(8.0),
        child: FlutterLogo(),
       // color: this._colorAnimation.value,
        height: this._sizeAnimation.value,
        width: this._sizeAnimation.value,


      ),
      Container(
        margin: EdgeInsets.all(10.00),
        child: Column(
          children: [
            RaisedButton(

              //padding: EdgeInsets.all(100.00),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.text_fields),
                  labelText: 'Enter Your Name',
                ),
              ),

              onPressed: this._controller.isCompleted ? null : () =>
                  _controller.forward(),
            ),
            RaisedButton(
              //padding: EdgeInsets.all(100.00),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.keyboard),
                  labelText: 'Enter Password',
                ),
              ),
              onPressed: this._controller.isDismissed ? null : () =>
                  _controller.reverse(),
            ),
            RaisedButton(
              child: Text(
                  'Sign In'
              ),
              onPressed: () {

                this._controller.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    this._controller.reverse();
                    showWelcomeScreen();
                  }
                  else if (status == AnimationStatus.dismissed) {
                    this._controller.forward();
                  }
                });
                this._controller.forward();
              },
            ),
          ],
        ),
      )

    ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
       child: Text('Signed in Suceesfully',style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}

