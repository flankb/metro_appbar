library metro_appbar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Collapsed command in Popup Menu.
class SecondaryCommand extends StatelessWidget {
  /// Function that will invoked on click
  final VoidCallback onPressed;

  /// The displayed text of the this menu item
  final String text;

  /// You may pass style of [text] if you provide
  final TextStyle style;

  SecondaryCommand({
    @required this.onPressed,
    @required this.text,
    this.style,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

/// Primary visible menu item with [icon] and [text]
class PrimaryCommand extends StatelessWidget {
  ///Function that will invoked on click
  final VoidCallback onPressed;

  /// Icon that reltive to this command
  final IconData icon;

  /// Color for [icon] and [text]
  final Color color;

  /// Text that displayed in menu button
  /// if pass null, only icon will be visible
  final String text;

  /// Width of this button
  final double width;

  const PrimaryCommand({
    Key key,
    @required this.onPressed,
    @required this.icon,
    this.color,
    this.text,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width ?? 82),
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 28, child: Icon(icon, color: color)),
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

/// Menu with visible [primaryCommands] and collapsed [secondaryCommands]
class MetroAppBar extends StatefulWidget {
  /// Visible menu items with a picture and optional text
  final List<Widget> primaryCommands;

  /// Hidden in the pop-up menu commands with text
  final List<Widget> secondaryCommands;

  /// Color of whole [MetroAppBar]
  final Color backgroundColor;

  /// Color of icon of button that open secondary menu
  final Color secondaryOpenButtonColor;

  /// Height of [MetroAppBar]
  final double height;

  /// Radius of whole [MetroAppBar]
  final BorderRadius borderRadius;

  /// The degree of the imaginary height of the element above the substrate.
  /// Adjusts the size of the shadow
  final double elevation;

  const MetroAppBar(
      {Key key,
      @required this.primaryCommands,
      this.secondaryCommands,
      this.backgroundColor,
      this.height,
      this.borderRadius = BorderRadius.zero,
      this.elevation = 12,
      this.secondaryOpenButtonColor})
      : super(key: key);

  @override
  _MetroAppBarState createState() => _MetroAppBarState();
}

class _MetroAppBarState extends State<MetroAppBar>
    with SingleTickerProviderStateMixin {
  Map<int, Widget> _secondaryCommandWraps = Map();

  _updateProperties() {
    _secondaryCommandWraps.clear();

    if (widget.secondaryCommands != null) {
      widget.secondaryCommands.asMap().forEach((index, value) {
        _secondaryCommandWraps[index] = value;
      });
    }
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
    final height = widget.height ?? 56;

    return Material(
      elevation: widget.elevation,
      type: MaterialType.card,
      borderRadius: widget.borderRadius,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            // borderRadius: widget.borderRadius,
            color: widget.backgroundColor ??
                (theme != null ? theme.bottomAppBarColor : Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          for (var pc in widget.primaryCommands) pc,
                        ],
                      ),
                    ),
                  ),
                  widget.secondaryCommands != null &&
                          widget.secondaryCommands.any((element) => true)
                      ? PopupMenuButton<int>(
                          icon: Icon(Icons.more_vert,
                              color: widget.secondaryOpenButtonColor),
                          color: widget.backgroundColor ??
                              (theme != null
                                  ? theme.bottomAppBarColor
                                  : Colors.white),
                          onSelected: (command) {
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
