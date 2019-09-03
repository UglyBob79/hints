// Copyright 2019 Mattias Månsson. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hints/hints.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isEnabled = true;

  @override
  void initState() {
    super.initState();

    //HintCard.resetHidden();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HintCard(
              key: Key('MyUniqueHintKey'),
              text:
              'This is a little help text for the first time user. Just press the little X to dismiss it forever...',
            ),
            HintCard(
              key: Key('MyUniqueHintKey2'),
              text:
              'This is a 2nd little help text for the first time user. Just press the little X to dismiss it forever...',
            ),
            HintCard(
              key: Key('MyUniqueHintKey3'),
              text:
              'This is a 3rd little help text for the first time user. Just press the little X to dismiss it forever...',
            ),
            FlatButton(
              child: Text('Reset'),
              onPressed: () async {
                await HintCard.resetHidden();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
