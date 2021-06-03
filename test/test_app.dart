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
  MyTestHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  MyTestHomePageState createState() => MyTestHomePageState();
}

class MyTestHomePageState extends State<MyTestHomePage> {
  String pushedButtonText = '';

  void _setPushedButtonText(String text) {
    setState(() {
      pushedButtonText = text;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
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
            MetroAppBar(
              primaryCommands: [
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText('Eiusmod');
                    },
                    color: Colors.green,
                    icon: Icons.account_balance_rounded,
                    text: 'Eiusmod'),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText('Lorem ipsum dolor');
                    },
                    icon: Icons.ac_unit,
                    color: Colors.amber,
                    width: 80,
                    text: 'Lorem ipsum dolor'),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText('Ipsum');
                    },
                    icon: Icons.accessible_outlined,
                    text: 'Ipsum'),
                PrimaryCommand(
                    onPressed: () {
                      _setPushedButtonText('Dolor');
                    },
                    icon: Icons.picture_in_picture_alt_rounded,
                    text: 'Dolor'),
                PrimaryCommand(
                  //color: _currentStyle.firstButtonColor,
                  onPressed: () {
                    _setPushedButtonText('Empty');
                  },
                  icon: Icons.event_note, /*text: "Next"*/
                )
              ],
              secondaryCommands: [
                SecondaryCommand(
                    onPressed: () {
                      _setPushedButtonText('Secondary');
                    },
                    text: 'Secondary')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
