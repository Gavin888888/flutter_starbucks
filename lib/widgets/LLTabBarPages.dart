import 'package:flutter/material.dart';
import 'package:flutter_starbucks/pages/home/home.dart';
import 'package:flutter_starbucks/pages/welfare/welfare.dart';
import 'package:flutter_starbucks/pages/payQr/parQr.dart';
import 'package:flutter_starbucks/pages/message/message.dart';
import 'package:flutter_starbucks/pages/me/me.dart';
import 'package:flutter_starbucks/constant/color_constant.dart';

class LLTabBarPages extends StatefulWidget {
  LLTabBarPages({Key key}) : super(key: key);

  @override
  _LLTabBarPagesState createState() => _LLTabBarPagesState();
}

class _LLTabBarPagesState extends State<LLTabBarPages> with TickerProviderStateMixin {
  //动画
  List animationControllers = [];
  //当前选中的tabbar索引
  int currentIndex;
  final pages = [LLHomePage(), LLWelfarePage(), LLMessagePage(),LLMePage()];
  List titles = ["首页", "福利购","星消息", "我"];
  List normalImgUrls = [
    "assets/images/platform_tabbar_home_empty~iphone.png",
    "assets/images/platform_tabbar_gift_empty~iphone.png",
    "assets/images/platform_tabbar_inbox_empty~iphone.png",
    "assets/images/platform_tabbar_account_empty~iphone.png"];
  List selectedImgUrls = [
    "assets/images/platform_tabbar_home_filled~iphone.png",
    "assets/images/platform_tabbar_gift_filled~iphone.png",
    "assets/images/platform_tabbar_inbox_filled~iphone.png",
    "assets/images/platform_tabbar_account_filled~iphone.png",
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    for(String title in titles){
      AnimationController controller = AnimationController(
          duration: Duration(milliseconds: 50), vsync: this,lowerBound: 0.9); //AnimationController
      animationControllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 5;

    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: FloatingActionButton(
          child: Image.asset("assets/images/platform_home_frap_qrcode~iphone.png", width: 25, height: 25),
          onPressed: (){
            print("你点击了ADD");

          },
          elevation: 5,
          backgroundColor: ColorConstant.MainColor,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 49, width: itemWidth, child: tabbar(0)),
              SizedBox(height: 49, width: itemWidth, child: tabbar(1)),
              SizedBox(height: 49, width: itemWidth, ),
              SizedBox(height: 49, width: itemWidth, child: tabbar(2)),
              SizedBox(height: 49, width: itemWidth, child: tabbar(3)),

            ]
        ),
      ),
      body: pages[currentIndex],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for(AnimationController controller in animationControllers) {
        controller.dispose();
    }
  }

// 自定义tabbaritem
  Widget tabbar(int index) {
    //设置默认未选中的状态
    TextStyle style = TextStyle(fontSize: 11, color: Colors.black);
    String imgUrl = normalImgUrls[index];
    AnimationController controller = animationControllers[index];
    double icon_wh = 25;
    if (currentIndex == index) {
      //选中的话
      style = TextStyle(fontSize: 11, color: ColorConstant.MainColor);
      imgUrl = selectedImgUrls[index];
    }
    //构造返回的Widget
    Widget item = Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            Image.network(imgUrl, width: 25, height: 25),
          SizedBox(height: 5,),
            Image.asset(imgUrl, width: icon_wh, height: icon_wh),
            Text(
              titles[index],
              style: style,
            )
          ],
        ),
        onTap: () {
          if (currentIndex != index) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );

    Widget scaleitem = ScaleTransition(
      //设置动画的缩放中心
      alignment: Alignment.center,
      //动画控制器
      scale: controller,
      //将要执行动画的子view
      child: item,
    );
    if (currentIndex == index){
      //正向动画开始
      controller.forward();
    }else{
      controller.reverse();
    }
    return scaleitem;
  }
}
