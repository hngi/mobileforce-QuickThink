import 'package:flutter/material.dart';

class SelectedDiff extends StatelessWidget {
  final String title;

  const SelectedDiff({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
