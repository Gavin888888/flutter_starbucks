import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_marquee/flutter_marquee.dart';

class LLWelfarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("福利购"),
      ),
      body: Column(
        children: <Widget>[
          Text("从上到下,时间间隔8秒,传入的是自定义的text widget"),
          Container(
            margin: EdgeInsets.all(4),
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: FlutterMarquee(
                children: <Widget>[
                  Text(
                    "刘成",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text("刘成1111", style: TextStyle(color: Colors.green)),
                  Text("刘成2222", style: TextStyle(color: Colors.blue)),
                  Text("刘成3333",
                      style: TextStyle(color: Colors.yellow)),
                ],
                onChange: (i) {
                  print(i);
                },
                animationDirection: AnimationDirection.t2b,
                duration: 4,
              ),
          )
        ],
      ),
    );
  }
}
