import 'package:flutter/material.dart';
import 'package:metro_appbar/metro_appbar.dart';

class TestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetroAppBar sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyTestHomePage(title: 'MetroAppBar test app'),
    );
  }
}

class MyTestHomePage extends StatefulWidget {
  MyTestHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyTestHomePageState createState() => MyTestHomePageState();
}

// class AppBarStyle {
//   final Color color;
//   final Color firstButtonColor;
//   final double height;

//   AppBarStyle(this.color, this.firstButtonColor, this.height);
// }

class MyTestHomePageState extends State<MyTestHomePage> {
  String pushedButtonText = "";
  //AppBarStyle _currentStyle;

  void _setPushedButtonText(String text) {
    setState(() {
      pushedButtonText = text;
    });
  }

  // void _updateStyle() {
  //   setState(() {
  //     _currentStyle =
  //         _styles[(_styles.indexOf(_currentStyle) + 1) % _styles.length];
  //   });
  // }

  @override
  void initState() {
    super.initState();

    //_currentStyle = _styles[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You pushed the button:',
                    ),
                    Text(
                      '$pushedButtonText',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ]),
            )),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: RawMaterialButton(
            //       onPressed: () {
            //         _updateStyle();
            //       },
            //       fillColor: Colors.blue,
            //       child: Text('Change style'),
            //     ),
            //   ),
            // ),
            MetroAppBar(
              // backgroundColor: _currentStyle.color,
              // height: _currentStyle.height,
              primaryCommands: [
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText("Eiusmod");
                    },
                    color: Colors.green,
                    pic: Icons.account_balance_rounded,
                    text: "Eiusmod"),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText("Lorem ipsum dolor");
                    },
                    pic: Icons.ac_unit,
                    color: Colors.amber,
                    width: 80,
                    text: "Lorem ipsum dolor"),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText("Ipsum");
                    },
                    pic: Icons.accessible_outlined,
                    text: "Ipsum"),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText("Dolor");
                    },
                    pic: Icons.picture_in_picture_alt_rounded,
                    text: "Dolor"),
                PrimaryCommand(
                  //color: _currentStyle.firstButtonColor,
                  onPressed: () {
                    _setPushedButtonText("Empty");
                  },
                  pic: Icons.event_note, /*text: "Next"*/
                )
              ],
              secondaryCommands: [
                SecondaryCommand(
                    onPressed: () {
                      _setPushedButtonText("Secondary");
                    },
                    text: "Secondary")
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 60.0),
      //   child: FloatingActionButton(
      //     onPressed: _incrementCounter,
      //     tooltip: 'Increment',
      //     child: Icon(Icons.add),
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}