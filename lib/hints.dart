library hints;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HintCard extends StatefulWidget {
  // The text to show on the hint card
  final String text;
  // The icon to show on the hint card.
  // This will default to a info icon if not set.
  final Icon icon;
  // This bool value decides if to show a dismiss button or not.
  final bool showDismiss;

  HintCard({
    @required Key key,
    @required this.text,
    this.icon = const Icon(
      Icons.info_outline,
      color: Colors.lightBlueAccent,
      size: 48,
    ),
    this.showDismiss = true,
  })  : assert(key != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _HintCardState();

  static Future<void> resetHidden() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('hints', []);
  }
}

class _HintCardState extends State<HintCard> {
  bool visible = true;

  @override
  void initState() {
    super.initState();

    _shouldShow().then((result) {
      setState(() {
        visible = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // A bit ugly, but it was the easiest way to make sure that the reset works
    _updateShow();

    return Visibility(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 10.0), child: widget.icon),
                Flexible(
                  child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ),
                Visibility(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          visible = false;
                          _setShow(false);
                        });
                      },
                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  visible: widget.showDismiss,
                )
              ],
            ),
          ),
        ),
      ),
      visible: visible,
    );
  }

  Future<bool> _shouldShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> hideList = prefs.getStringList('hints') ?? [];
    return !hideList.contains(widget.key.toString());
  }

  void _setShow(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> hideList = prefs.getStringList('hints') ?? [];

    if (show && hideList.contains(widget.key.toString()))
      hideList.remove(widget.key);

    if (!show && !hideList.contains(widget.key.toString()))
      hideList.add(widget.key.toString());

    await prefs.setStringList('hints', hideList);
  }

  // Update visibility in case all hints were reset
  void _updateShow() async {
    bool show = await _shouldShow();
    if (visible != show)
      setState(() {
        visible = show;
      });
  }
}
