library metro_appbar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// abstract class SimpleCommand {
//   final String commandName;
//   final VoidCallback onPressed;

//   SimpleCommand(this.commandName, this.onPressed);
// }

/// Collapsed command in Popup Menu.
/// One of child or [text] with [onPressed] may be provided, but not both
class SecondaryCommand extends StatelessWidget {
  //final String commandName;

  /// Func will emited on click if you pass [text]
  final VoidCallback onPressed;

  /// If provided, the [text] is used for this command
  /// and the item will behave like an [Text].
  final String text;

  /// You may pass style of text if you provide [text]
  final TextStyle style;

  // /// Provide widget represented this Item
  // /// If provided, [child] is the widget used for this button
  // /// and the button will utilize an [InkWell] for taps.
  // final Widget child;

  SecondaryCommand({
    //@required this.commandName,
    @required this.onPressed,
    this.text,
    this.style,
    /*this.child*/
  }) : assert(text != null /* || child != null*/);

  @override
  Widget build(BuildContext context) {
    return /*child ??*/ Text(text, style: style);
  }
}

class PrimaryCommand extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData pic;
  final Color color;
  final String text;
  final double width;

  const PrimaryCommand({
    Key key,
    @required this.onPressed,
    @required this.pic,
    this.color,
    this.text,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          /*minHeight: 56, maxHeight: 56,*/ maxWidth: width ?? 96),
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 28, child: Icon(pic, color: color)),
            if (text != null)
              Text(
                text,
                maxLines: 1,
                style: TextStyle(fontSize: 10, color: color), // Add color?
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
  final List<Widget> secondaryCommands;
  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;
  final double elevation;

  const MetroAppBar(
      {Key key,
      @required this.primaryCommands,
      this.secondaryCommands,
      this.backgroundColor,
      this.height,
      this.borderRadius = BorderRadius.zero,
      this.elevation = 12})
      : super(key: key);

  @override
  _MetroAppBarState createState() => _MetroAppBarState();
}

class _MetroAppBarState extends State<MetroAppBar>
    with SingleTickerProviderStateMixin {
  Map<int, Widget> _secondaryCommandWraps = Map();
  //double _backgroundColorLuminance;

  _updateProperties() {
    _secondaryCommandWraps.clear();
    // _backgroundColorLuminance = widget.backgroundColor == null
    //     ? 1
    //     : widget.backgroundColor.computeLuminance();

    if (widget.secondaryCommands != null) {
      widget.secondaryCommands.asMap().forEach((index, value) {
        _secondaryCommandWraps[index] = value;
      });
    }

    //debugPrint("Luminance $_backgroundColorLuminance");
  }

  @override
  void initState() {
    super.initState();
    _updateProperties();
  }

  @override
  void didUpdateWidget(covariant MetroAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateProperties();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: widget.elevation,
      type: MaterialType.card,
      borderRadius: widget.borderRadius,
      child: Container(
        height: widget.height ?? 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor ??
              (theme != null ? theme.bottomAppBarColor : Colors.white),
          // boxShadow: [
          //   BoxShadow(
          //     color: theme != null && theme.brightness == Brightness.dark
          //         ? const Color(0xff3F3C3C)
          //         : const Color(0xffd3d3d3),
          //     //color: Colors.grey,
          //     blurRadius: 5.5,
          //     spreadRadius: 0.5,
          //     offset: Offset(0, 0.5), // shadow direction: bottom right
          //   )
          // ],
          // borderRadius: new BorderRadius.horizontal(
          //   left: new Radius.circular(0.0),
          //   right: new Radius.circular(0.0),
          // )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  for (var pc in widget.primaryCommands) pc,
                  widget.secondaryCommands != null &&
                          widget.secondaryCommands.any((element) => true)
                      ? PopupMenuButton<int>(
                          color: widget.backgroundColor ??
                              (theme != null
                                  ? theme.bottomAppBarColor
                                  : Colors.white),
                          onSelected: (command) {
                            // Определить нужную команду
                            final cmdWidget = _secondaryCommandWraps[command];

                            if (cmdWidget is SecondaryCommand) {
                              cmdWidget.onPressed();
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return _secondaryCommandWraps.entries.map((e) {
                              return PopupMenuItem<int>(
                                value: e.key,
                                child: e.value,
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
      ),
    );
  }
}
