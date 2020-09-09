import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

class LLMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("11"),),
      body: _marqueeView(context),
    );
  }

  Widget _marqueeview() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 31,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Center(
              child: Image.asset(
                'assets/icon_laba.png',
                width: 15,
                height: 15,
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: YYMarquee(
                  stepOffset: 200.0,
                  duration: Duration(seconds: 5),
                  paddingLeft: 50.0,
                  children: [
                    Text(
                      '手机用户155****0523借款成功',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFEE8E2B),
                      ),
                    ),
                    Text(
                      '手机用户1345****0531借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户145****0555借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户175****0594借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户185****0521借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                  ],
                ),
              )),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFF2E6),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
//  2.纵向滚动，纵向滚动我这里使用的是flutter_Swiper实现的滚动

  final list = [
    '3月1日王女士（卡号5346）成功借款10000',
    '4月3日李女士（卡号3232）成功借款30000',
//    '2月6日王先生（卡号4432）成功借款10000',
//    '4月2日刘女士（卡号8908）成功借款50000',
//    '1月1日张女士（卡号0894）成功借款100000',
//    '10月1日陈先生（卡号7233）成功借款80000',
//    '9月1日吴女士（卡号7298）成功借款10000',
  ];
  // 轮播
  Widget _marqueeView(context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        color: Colors.red,
        height: 50,
        child: _marqueeSwiper(context),
      ),
    );
  }

  Widget _marqueeSwiper(context) {
    return Container(
      height: 34,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      color: Colors.indigoAccent,
      child: Swiper(
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        loop: true,
        autoplay: true,
        duration:1000,
        curve: Curves.easeInOut,
          fade:0.5,
        itemBuilder: (BuildContext context, int index) {
          // return Text('3月1日李女士（卡号5666）成功借款10000');
          return Container(
            height: 34,
            alignment: Alignment.center,
            child: Text(
              list[index],
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}




class YYMarquee extends StatefulWidget {
  Duration duration; // 轮播时间
  double stepOffset; // 偏移量
  double paddingLeft; // 内容之间的间距
  List<Widget>children = [];  //内容
  YYMarquee(
      {
        this.paddingLeft,
        this.duration,
        this.stepOffset,
        this.children});
  _YYMarqueeState createState() => _YYMarqueeState();
}

class _YYMarqueeState extends State<YYMarquee> {
  ScrollController _controller; // 执行动画的controller
  Timer _timer; // 定时器timer
  double _offset = 0.0; // 执行动画的偏移量

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration, (timer) {
      double newOffset = _controller.offset + widget.stepOffset;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration, curve: Curves.linear); // 线性曲线动画
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _child() {
    return new Row(children: _children());
  }

  // 子视图
  List<Widget> _children() {
    List<Widget> items = [];
    List list = widget.children;
    for (var i = 0; i < list.length; i++) {
      Container item = new Container(
        margin: new EdgeInsets.only(right: widget.paddingLeft),
        child: list[i],
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal, // 横向滚动
      controller: _controller, // 滚动的controller
      itemBuilder: (context, index) {
        return _child();
      },
    );
  }
}