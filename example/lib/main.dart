import 'package:flutter/material.dart';
import 'package:metro_appbar/metro_appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetroAppBar sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MetroAppBar sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class AppBarStyle {
  final Color? color;
  final Color firstButtonColor;
  final double? height;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final bool withSecondary;

  AppBarStyle(this.color, this.firstButtonColor, this.height, this.borderRadius,
      this.padding,
      {this.withSecondary = true});
}

class _MyHomePageState extends State<MyHomePage> {
  final List<AppBarStyle> _styles = [
    AppBarStyle(null, Colors.red, null, BorderRadius.zero, EdgeInsets.all(0)),
    AppBarStyle(Colors.pink[50], Colors.green, 60, BorderRadius.circular(12),
        EdgeInsets.fromLTRB(8, 8, 8, 12)),
    AppBarStyle(Colors.green[100], Colors.purple, 72, BorderRadius.zero,
        EdgeInsets.all(0)),
    AppBarStyle(Colors.red, Colors.cyan, null, BorderRadius.circular(36),
        EdgeInsets.all(6),
        withSecondary: false),
    AppBarStyle(Colors.indigo[400], Colors.white, null, BorderRadius.zero,
        EdgeInsets.all(0),
        withSecondary: false),
  ];

  String _pushedButtonText = '';
  late AppBarStyle _currentStyle;

  void _setPushedButtonText(String text) {
    setState(() {
      _pushedButtonText = text;
    });
  }

  void _updateStyle() {
    setState(() {
      _currentStyle =
          _styles[(_styles.indexOf(_currentStyle) + 1) % _styles.length];
    });
  }

  @override
  void initState() {
    super.initState();

    _currentStyle = _styles[0];
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
                      '$_pushedButtonText',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RawMaterialButton(
                        padding: const EdgeInsets.all(6.0),
                        onPressed: () {
                          _updateStyle();
                        },
                        fillColor: Colors.blue,
                        child: Text(
                          'Change style',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
            )),
            Padding(
              padding: _currentStyle.padding,
              child: MetroAppBar(
                backgroundColor: _currentStyle.color,
                borderRadius: _currentStyle.borderRadius,
                height: _currentStyle.height,
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
                        _setPushedButtonText('Reprehenderit qui');
                      },
                      icon: Icons.ac_unit,
                      color: Colors.amber,
                      width: 80,
                      text: 'Reprehenderit qui'),
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
                    color: _currentStyle.firstButtonColor,
                    onPressed: () {
                      _setPushedButtonText('Velit');
                    },
                    icon: Icons.event_note,
                  )
                ],
                secondaryCommands: _currentStyle.withSecondary
                    ? [
                        SecondaryCommand(
                            onPressed: () {
                              _setPushedButtonText('Commodo');
                            },
                            text: 'Commodo'),
                        SecondaryCommand(
                            onPressed: () {
                              _setPushedButtonText('Officia');
                            },
                            text: 'Officia'),
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
