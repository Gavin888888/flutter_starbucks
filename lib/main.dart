import 'package:flutter/material.dart';
import 'package:flutter_starbucks/widgets/LLTabBarPages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootViewController()
    );
  }
}
class RootViewController extends StatefulWidget {
  RootViewController({Key key}) : super(key: key);

  @override
  _RootViewControllerState createState() => _RootViewControllerState();
}

class _RootViewControllerState extends State<RootViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(child: LLTabBarPages());
  }
}