// This is the minimum implementation while waiting for the result screen
import 'package:flutter/material.dart';
import 'package:share/share.dart';

shareResult(BuildContext context){
  final RenderBox box = context.findRenderObject();
  // placeholder for the result
  String subject = "QuickThink App Score";
  String result = '60%';
  String questionTotal = '20';
  String appName = 'QuickThink from HNG Tech Limited';
  String resultSummary = "Hi, I scored $result out of $questionTotal questions in $appName. Do you think you can beat me? Join me and compete";

  Share.share(resultSummary, subject: subject, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

class ShareResult extends StatefulWidget {
  ShareResult({Key key}) : super(key: key);

  @override
  _ShareResultState createState() => _ShareResultState();
}

class _ShareResultState extends State<ShareResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Share'),
          onPressed: (){
          shareResult(context);
        },
  
        )
      ),
    );
  }
}