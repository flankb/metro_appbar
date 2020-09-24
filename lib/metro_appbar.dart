library metro_appbar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondaryCommand extends StatelessWidget {
  final String commandName;
  final VoidCallback onPressed;
  final String text;
  final TextStyle style;
  final Widget child;

  SecondaryCommand(
      {@required this.commandName,
      @required this.onPressed,
      @required this.text,
      this.style,
      this.child});

  @override
  Widget build(BuildContext context) {
    return child ?? Text(text, style: style);
  }
}

class PrimaryCommand extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData pic;
  final Color color;
  final String text;

  const PrimaryCommand({
    Key key,
    @required this.onPressed,
    @required this.pic,
    this.color,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 56, maxHeight: 56, maxWidth: 110),
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 28, child: Icon(pic, color: color)),
            Text(
              text,
              maxLines: 1,
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

class MetroAppBar extends StatefulWidget {
  final List<Widget> primaryCommands;
  final List<SecondaryCommand> secondaryCommands;

  const MetroAppBar(
      {Key key, @required this.primaryCommands, this.secondaryCommands})
      : super(key: key);

  @override
  _MetroAppBarState createState() => _MetroAppBarState();
}

class _MetroAppBarState extends State<MetroAppBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff3F3C3C)
                  : const Color(0xffd3d3d3),
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.3, 0.3), // shadow direction: bottom right
            )
          ],
          borderRadius: new BorderRadius.horizontal(
            left: new Radius.circular(0.0),
            right: new Radius.circular(0.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                for (var pc in widget.primaryCommands) pc,
                widget.secondaryCommands != null &&
                        widget.secondaryCommands.any((element) => true)
                    ? PopupMenuButton<String>(
                        onSelected: (command) {
                          // Определить нужную команду
                          final cmd = widget.secondaryCommands.singleWhere(
                              (element) => element.commandName == command);
                          cmd.onPressed();
                        },
                        itemBuilder: (BuildContext context) {
                          return widget.secondaryCommands.map((e) {
                            return PopupMenuItem<String>(
                              value: e.commandName,
                              child: e,
                            );
                          }).toList();
                        },
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
