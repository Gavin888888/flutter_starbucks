import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 50), vsync: this,lowerBound: 0.7); //AnimationController

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);


//动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(35),
              child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    if (controller.isCompleted) {
                      //反向开始
                      controller.reverse();
                    } else {
                      //正向动画开始
                      controller.forward();
                    }
                  },
                  child: Text("开始")),
            ),
            buildRotationTransition(),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //缩放
  Widget buildRotationTransition() {
    return Center(
      child: ScaleTransition(
        //设置动画的缩放中心
        alignment: Alignment.center,
        //动画控制器
        scale: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
      ),
    );
  }
}
