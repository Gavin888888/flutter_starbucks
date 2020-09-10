import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_starbucks/constant/color_constant.dart';
import 'package:flutter_starbucks/pages/home/titleAnimation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:toast/toast.dart';

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

  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      Toast.show('当前已是最新数据', context);
    });
  }

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
      extraPicHeight = extraPicHeight <= 0 ? 0 : extraPicHeight;
      fitType = fitType;

      print("-----prev_dy=${prev_dy}");
      print("-----extraPicHeight=${extraPicHeight}");
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
    double rpx = MediaQuery.of(context).size.width / 750;

    return RefreshIndicator(
      onRefresh: this.onRefresh,
      child: Listener(
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
              pinned: false,
              floating: false,
              expandedHeight: 180 + extraPicHeight * 0.2,
              backgroundColor: Color(0x00ffffff),
              flexibleSpace: FlexibleSpaceBar(
                background: SliverTopBar(
                  extraPicHeight: extraPicHeight,
                  fitType: fitType,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  Container postPiece;
                  if (index == 0) {
                    postPiece = Container(child: createredits());
                  }
                  if (index == 1) {
                    postPiece = Container(child: createLocation());
                  }
                  if (index == 2) {
                    postPiece = Container(child: createCard(width));
                  }
                  if (index == 3) {
                    postPiece = Container(child: createwillExpiredCoupons());
                  }
                  if (index == 4) {
                    postPiece = Container(child: EveryDayStar());
                  }
                  if (index == 5) {
                    postPiece = Container(child: SpecialOffer());
                  }
                  return postPiece;
                },
                childCount: 50,
              ),
            ),
//          SliverList(
//              delegate: SliverChildBuilderDelegate((context, index) {
//            return EveryDayStar();
//          }, childCount: 1))
          ],
        ),
      ),
    );
    //endregion
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

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
      {Key key, @required this.extraPicHeight, @required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double rpx = MediaQuery.of(context).size.width / 750;
    return Stack(
      children: [
        Image.asset(
          "assets/images/homepage.png",
          width: width,
          height: 217 + extraPicHeight * 0.2,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          height: 20,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class EveryDayStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Text(
                "星礼点亮每天",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            createItem("assets/images/temp.png"),
            createItem("assets/images/temp1.png"),
          ],
        ),
      ),
    );
  }

  Widget createItem(imgname) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Stack(
        children: [
          Image.asset(
            imgname,
            height: 150,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}

class SpecialOffer extends StatelessWidget {
  final List<String> imgs = [
    "https://artwork.starbucks.com.cn/banners-homepage-banner/main_61babe13-d569-476b-8bd6-e75068943318.jpg",
    "https://artwork.starbucks.com.cn/banners-homepage-banner/main_815bd96b-cf3f-407d-b623-26f35085bf99.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  child: Text(
                    "限时好礼",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Text(
                    "查看更多",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.MainColor),
                  ),
                ),
              ],
            ),

            Card(
              elevation: 3, //设置阴影
              shadowColor: Color(0xfff1f1f1),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child:Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  height: 150, // 高度 插件 flutter_screenutil
                  child: Swiper(
                    scrollDirection: Axis.horizontal,// 横向
                    itemCount: imgs.length,// 数量
                    autoplay: true, // 自动翻页
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(imgs[index],
                            fit: BoxFit.cover),
                      );
                    }, // 构建
                    onTap: (index) {print('点击了第${index}');},// 点击事件 onTap
                    pagination: SwiperPagination(// 分页指示器
                        alignment: Alignment.bottomCenter,// 位置 Alignment.bottomCenter 底部中间
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),// 距离调整
                        builder: DotSwiperPaginationBuilder( // 指示器构建
                            space: 5,// 点之间的间隔
                            size: 10, // 没选中时的大小
                            activeSize: 12,// 选中时的大小
                            color: Colors.black54,// 没选中时的颜色
                            activeColor: Colors.white)),// 选中时的颜色
//                control: new SwiperControl(color: Colors.pink), // 页面控制器 左右翻页按钮
//                  scale: 0.95,// 两张图片之间的间隔
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createItem(imgname) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Stack(
        children: [
          Image.asset(
            imgname,
            height: 150,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
