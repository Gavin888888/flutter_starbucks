import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
            expandedHeight:
                (227 * width) / 434 - 44 + extraPicHeight + 20 + 35 + 10 + 80,
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
            delegate: SliverChildBuilderDelegate((ctx, index) {
              return Text("$index");
            }, childCount: 300),
          )
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xfff1f1f1),
                ),
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 40,
                      child: Image.asset("assets/images/homeicon.png"),
                    ),
                    Text("星星月历来咯，点击查看你的8月有星人时刻"),
                    Image.asset('assets/images/account_icon_indicator_large~iphone.png',width: 8,)
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: (227 * width) / 434 + extraPicHeight - 10,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              height: 30,
              width: 750,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
