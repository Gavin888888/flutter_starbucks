import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

class LLWelfarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DiscoverListPage();
  }
}

class DiscoverListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoverListState();
}

class DiscoverListState extends State<DiscoverListPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: Center(
            child: ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: 15,
            ),
          )),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        //标题居中
        centerTitle: true,
        //展开高度200
        expandedHeight: 200.0,
        //不随着滑动隐藏标题
        floating: false,
        //固定在顶部
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
            fit: BoxFit.cover,
          ),
        ),
        //    bottom   这是新增的    这是新增的    这是新增的      这是新增的
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.cake), text: '左侧'),
            Tab(icon: Icon(Icons.golf_course), text: '右侧'),
          ],
          controller: TabController(length: 2, vsync: this),
        ),
      )
    ];
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('无与伦比的标题+$index'),
    );
  }
}

