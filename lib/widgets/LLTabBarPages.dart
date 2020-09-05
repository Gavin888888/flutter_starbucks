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

class _LLTabBarPagesState extends State<LLTabBarPages> {

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
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 5;

    return  Scaffold(
      appBar: AppBar(
        title: Text("底部导航栏"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(35),
//          color: Colors.white,
//        ),
        child: FloatingActionButton(
          child: Image.asset("assets/images/platform_home_frap_qrcode~iphone.png", width: 25, height: 25),
          onPressed: (){
            print("你点击了ADD");
            //调整进入Addpage()
          },
          elevation: 5,
          backgroundColor: ColorConstant.MainColor,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
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
// 自定义tabbaritem
  Widget tabbar(int index) {
    //设置默认未选中的状态
    TextStyle style = TextStyle(fontSize: 10, color: Colors.black);
    String imgUrl = normalImgUrls[index];
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
            Image.asset(imgUrl, width: 25, height: 25),
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
    return item;
  }
}
