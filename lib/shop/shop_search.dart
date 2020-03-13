import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chenfengflutter/shop/shop_search_drawer.dart';
import 'package:chenfengflutter/plugin/number_bar.dart';
import 'package:chenfengflutter/plugin/page_plugin.dart';
import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopSearch extends StatefulWidget {
  final shopName;

  ShopSearch({this.shopName = ''});

  @override
  _ShopSearchState createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  Map param = {'curr_page': 1, 'page_count': 20, "map_mode": false};
  Map param2 = {};
  Map searchData = {
    'service_type': [],
    'user_role': [],
  };
  Map orgSearchDataParam = {};
  String orderNo = '';
  String order = '';
  List logs = [];
  int count = 0;
  BuildContext _context;
  ScrollController _controller;
  bool loading = true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onRefresh() async {
    setState(() {
      param['curr_page'] = 1;
      getData(isRefresh: true);
    });
  }

//  void _onLoading() async{
//    // monitor network fetch
//    await Future.delayed(Duration(milliseconds: 1000));
//    // if failed,use loadFailed(),if no data return,use LoadNodata()
////    items.add((items.length+1).toString());
//    if(mounted)
//      setState(() {
//
//      });
//    _refreshController.loadComplete();
//  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _context = context;
    param['shop_name'] = widget.shopName;
    Timer(Duration(milliseconds: 200), () {
      getData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  getData({isRefresh: false}) async {
    ajax('CrmSearch-fetchShop', {'param': jsonEncode(param)}, true, (res) {
      if (mounted) {
        setState(() {
          logs = res['shop'] ?? [];
          count = int.tryParse('${res['shopCount'] ?? 0}');
          toTop();
          loading = false;
        });
        if (isRefresh) {
          _refreshController.refreshCompleted();
        }
      }
    }, () {
      setState(() {
        loading = false;
      });
    }, _context);
  }

  toTop() {
    _controller.animateTo(
      0,
      duration: new Duration(milliseconds: 300), // 300ms
      curve: Curves.bounceIn, // 动画方式
    );
  }

  getPage(page) {
    if (loading) return;
    param['curr_page'] += page;
    getData();
  }

  orderBy(val) {
    if (val == 'all') {
      param.remove('order');
    } else {
      param['order'] = val;
    }
    param['curr_page'] = 1;
    order = val;
    getData();
  }

  searchFun(obj) {
    searchData = obj;
    param['curr_page'] = 1;
    if (searchData['service_type'].isEmpty) {
      param.remove('service_type');
    } else {
      param['service_type'] = searchData['service_type'].join(',');
    }
    if (searchData['user_role'].isEmpty) {
      param.remove('user_role');
    } else {
      param['user_role'] = searchData['user_role'].join(',');
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('店铺搜索'),
        actions: <Widget>[Container()],
      ),
      endDrawer: Container(
        width: width * 0.7,
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: ShopSearchDrawer(
          searchData: searchData,
          searchFun: searchFun,
          width: width,
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
//          onLoading: _onLoading,
        child: ListView(
          controller: _controller,
          children: <Widget>[
            Container(
              height: 34,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffdddddd),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        orderBy('');
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '综合',
                                style: TextStyle(
                                  color: order == '' ? Color(0xffb10000) : CFColors.text,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: order == '' ? Color(0xffb10000) : CFColors.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        orderBy('g.sales_volume desc');
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '销量',
                                style: TextStyle(
                                  color: order == 'g.sales_volume desc' ? Color(0xffb10000) : CFColors.text,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: order == 'g.sales_volume desc' ? Color(0xffb10000) : CFColors.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (order == 'g.goods_price') {
                          orderBy('g.goods_price desc');
                        } else {
                          orderBy('g.goods_price');
                        }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '价格',
                                style: TextStyle(
                                  color: order == 'g.goods_price' || order == 'g.goods_price desc'
                                      ? Color(0xffb10000)
                                      : CFColors.text,
                                ),
                              ),
                            ),
                            Icon(
                              order == 'g.goods_price desc' ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                              color: order == 'g.goods_price' || order == 'g.goods_price desc'
                                  ? Color(0xffb10000)
                                  : CFColors.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
//                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text('筛选'),
                            ),
                            Icon(
                              Icons.filter_list,
                              size: 16,
                              color: CFColors.secondary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: NumberBar(count: count),
            ),
            loading
                ? Container(
                    child: CupertinoActivityIndicator(),
                  )
                : logs.isEmpty
                    ? Container(
                        alignment: Alignment.topCenter,
                        child: Text('无数据'),
                      )
                    //
                    : Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: logs.map<Widget>((item) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: EdgeInsets.only(right: 10),
                                          child: CachedNetworkImage(
                                            imageUrl: '$baseUrl${item['shop_logo']}',
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) => Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                            errorWidget: (context, url, error) => Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          '${item['shop_name']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text('服务类型：'),
                                        ),
                                        Expanded(
                                          child: Text('${item['service_type_name']}'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text('店铺角色：'),
                                        ),
                                        Expanded(
                                          child: Text('${item['role_name']}'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text('店铺地址：'),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${item['province_name']} ${item['city_name']} ${item['region_name']} ${item['shop_address']}'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: PagePlugin(
                current: param['curr_page'],
                total: count,
                pageSize: param['page_count'],
                function: getPage,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: CFFloatingActionButton(
        onPressed: toTop,
        child: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}
