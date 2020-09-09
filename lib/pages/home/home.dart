import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_starbucks/constant/color_constant.dart';
import 'package:flutter_starbucks/pages/home/titleAnimation.dart';

class LLHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScaffold();
  }
}

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("width=${width} height=${height}");
    return Scaffold(
      body: Container(
        child: HomeMain(width: width),
      ),
    );
  }
}

class HomeMain extends StatefulWidget {
  HomeMain({Key key, @required this.width}) : super(key: key);
  final double width;

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  //图片增加的高度
  double extraPicHeight = 0;

  //图片适应 类型
  BoxFit fitType;

  //记录上一次滑动的高度
  double prev_dy;

  double width;
  AnimationController animationController;
  Animation<double> anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prev_dy = 0;
    fitType = BoxFit.fitWidth;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  //更新图片高度
  updatePicHeight(changed) {
    if (prev_dy == 0) {
      prev_dy = changed;
    }
    extraPicHeight += changed - prev_dy;
    if (extraPicHeight >= 0) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }
    setState(() {
      prev_dy = changed;
      extraPicHeight = extraPicHeight;
      fitType = fitType;
    });
  }

  //回弹动画
  runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= 0) {
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.cover;
          }
          setState(() {
            extraPicHeight = anim.value;
            fitType = fitType;
          });
        });
      prev_dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Listener(
      onPointerMove: (result) {
        updatePicHeight(result.position.dy);
      },
      onPointerUp: (_) {
        runAnimate();
        animationController.forward(from: 0);
      },
      child: CustomScrollView(

        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: (227 * width) / 434 -
                44 +
                extraPicHeight ,
//                20 +
//                35 +
//                10 +
//                60 +
//                35 +
//                (((width - 30) / 2) * 274) / 482 +
//                10 +
//                60,
            backgroundColor: Colors.white,
//            flexibleSpace: new FlexibleSpaceBar(
//              background: Image.asset("assets/images/homepage.png", fit: BoxFit.cover),
//            ),
            flexibleSpace: FlexibleSpaceBar(
              background: SliverTopBar(
                extraPicHeight: extraPicHeight,
                fitType: fitType,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return EveryDayStar();
          }, childCount: 1))
        ],
      ),
    );
    //endregion
  }
}

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
      {Key key, @required this.extraPicHeight, @required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Image.asset(
              "assets/images/homepage.png",
              width: width,
              height: (227 * width) / 434 + extraPicHeight,
              fit: fitType,
            ),
//            SizedBox(
//              height: 20,
//            ),
//            createredits(),
//            LLTitleAnimation(),
//            createLocation(),
//            createCard(width),
//            createwillExpiredCoupons()
          ],
        ),
//        Positioned(
//          top: (227 * width) / 434 + extraPicHeight - 10,
//          child: ClipRRect(
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(8),
//              topRight: Radius.circular(8),
//            ),
//            child: Container(
//              height: 30,
//              width: 750,
//              color: Colors.white,
//            ),
//          ),
//        ),
      ],
    );
  }

  /*创建积分*/
  Widget createredits() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            height: 35,
            child: Row(
              children: [
                Text(
                  "4.8",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 203, 161, 86),
                )
              ],
            ),
          ),
          Container(
            height: 35,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
//                          side: BorderSide(color: Colors.red)
              ),
              color: Color.fromARGB(255, 203, 161, 86),
              onPressed: () {},
              child: Text(
                "8张好礼劵",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }



  /*创建定位*/
  Widget createLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Container(
        height: 30,
        child: Row(
          children: [
            Image.asset(
              "assets/images/home_icon_location~iphone.png",
              width: 15,
              height: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                "北京方庄通润商务会馆点 | 878m",
                style: TextStyle(color: Color(0xff6c6c6c)),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text("更多门店", style: TextStyle(color: Color(0xff4a4845))),
                  SizedBox(
                    width: 3,
                  ),
                  Image.asset(
                    'assets/images/account_icon_indicator_large~iphone.png',
                    width: 6,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*创建卡片*/
  Widget createCard(screenWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          createCardItem(screenWidth, "啡快", "食品双倍星", "在线点，到店取",
              "assets/images/home_icon_pickup_entrance~iphone.png"),
          createCardItem(screenWidth, "专星送", "满80免配", "植物基膳食新品尝鲜",
              "assets/images/home_icon_delivery_entrance~iphone.png"),
        ],
      ),
    );
  }

  /*创建卡片item*/
  Widget createCardItem(screenWidth, title, subTitle, content, imgName) {
    return SizedBox(
      width: (screenWidth - 30) / 2,
      height: (((screenWidth - 30) / 2) * 274) / 482,
      child: Card(
          elevation: 8.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))), //设置圆角
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 35,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                            color: Color(0xffff6842),
                            child: Text(
                              subTitle,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      content,
                      style: TextStyle(
                          fontSize: 12, color: ColorConstant.MainColor),
                    ),
                  )
                ],
              ),
              Positioned(
                right: 10,
                bottom: 10,
                width: 50,
                height: 50,
                child: Image.asset(imgName),
              )
            ],
          )),
    );
  }

  /*willExpiredCoupons*/
  Widget createwillExpiredCoupons() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Color.fromRGBO(241, 241, 241, 0.7),
        ),
        height: 40,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Icon(
                  Icons.close,
                  color: Color(0xff4c4c4c),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(child: Text("您有4个好礼即将过期")),
              Text(
                "立即查看",
                style: TextStyle(color: ColorConstant.MainColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EveryDayStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [Container(color: Colors.red,child: Text("信息",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),), createItem(), createItem(), createItem(), createItem(), createItem(), createItem()],
      ),
    );
  }

  Widget createItem() {
    return Stack(
      children: [Image.asset("assets/images/temp.png",height: 150,fit: BoxFit.fill,)],
    );
  }
}
