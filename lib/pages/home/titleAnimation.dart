import 'package:flutter/material.dart';
import 'package:flutter_starbucks/pages/home/titleAnimationModel.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LLTitleAnimation extends StatefulWidget {
  final List<TitleAnimationModel> datas;

  LLTitleAnimation({@required this.datas});

  @override
  _LLTitleAnimationState createState() => _LLTitleAnimationState();
}

class _LLTitleAnimationState extends State<LLTitleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final list = [
    '星星好礼劵✨',
    '4月3日李女士（卡号3232）',
  ];

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(milliseconds: 10), vsync: this);
    print("--------${_controller}");
    _controller.forward();
    super.initState();
//    //动画开始、结束、向前移动或向后移动时会调用StatusListener
//    _controller.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        //动画从 controller.reverse() 反向执行 结束时会回调此方法
//        print("status is completed");
//        // controller.reset(); 将动画重置到开始前的状态
//        //开始执行
//        //controller.forward();
//      } else if (status == AnimationStatus.dismissed) {
//        //动画从 controller.forward() 正向执行 结束时会回调此方法
//        print("status is dismissed");
//        //controller.forward();
//      } else if (status == AnimationStatus.forward) {
//        print("status is forward");
//        //执行 controller.forward() 会回调此状态
//      } else if (status == AnimationStatus.reverse) {
//        //执行 controller.reverse() 会回调此状态
//        print("status is reverse");
//      }
//    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(241, 241, 241, 0.7),
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ScaleTransition(
                    //设置动画的缩放中心
                    alignment: Alignment.center,
                    //动画控制器
                    scale: _controller,
                    //将要执行动画的子view
                    child: Image.asset(
                      "assets/images/homeicon.png",
                      width: 20,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                width: 8,
              ),

              Expanded(
                child: Swiper(
                  itemCount: list.length,
                  scrollDirection: Axis.vertical,
                  loop: true,
                  autoplay: true,
                  duration: 1500,
                  curve: Curves.easeInOut,
                  fade: 0.8,
                  onIndexChanged: (index) {
//                    _controller.reset();
//                    _controller.forward();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
//                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        list[index],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Image.asset(
                'assets/images/account_icon_indicator_large~iphone.png',
                width: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
