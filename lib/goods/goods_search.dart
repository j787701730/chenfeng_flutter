import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chenfengflutter/goods/goods_search_drawer.dart';
import 'package:chenfengflutter/plugin/number_bar.dart';
import 'package:chenfengflutter/plugin/page_plugin.dart';
import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsSearch extends StatefulWidget {
  final goodsName;

  GoodsSearch({this.goodsName = ''});

  @override
  _GoodsSearchState createState() => _GoodsSearchState();
}

class _GoodsSearchState extends State<GoodsSearch> {
  Map param = {'curr_page': 1, 'page_count': 20, 'shop_name': true, 'audit_state': 1};
  Map param2 = {};
  Map searchData = {
    'goodsSpec': [],
    'goodsParam': [],
    'goodsParamExt': [],
    'goods': {
      'shop_name': true,
      'audit_state': 1,
    }
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
    param['goods_name'] = widget.goodsName;
    searchData['goods']['goods_name'] = widget.goodsName;
    Timer(Duration(milliseconds: 200), () {
      getData();
      getDataParam();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  getData({isRefresh: false}) async {
    Map data = {'goods': jsonEncode(param)};
    param2.forEach((k, v) {
      data[k] = v;
    });
    print(data);
    ajaxSimple('GoodsSearch-search', data, (res) {
      if (mounted) {
        setState(() {
          logs = res['goods'] ?? [];
          count = int.tryParse('${res['goodsCount'] ?? 0}');
          toTop();
          loading = false;
        });
        if (isRefresh) {
          _refreshController.refreshCompleted();
        }
      }
    });
  }

  getDataParam({isRefresh: false}) async {
    setState(() {
      loading = true;
    });
    Map temp = jsonDecode(jsonEncode(searchData));
    temp['goods'] = jsonEncode(temp['goods']);
    ajaxSimple('GoodsSearch-getSearchParam', temp, (res) {
      if (mounted) {
        setState(() {
          orgSearchDataParam = res.isEmpty ? {} : res;
        });
      }
    });
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
    print(param);
    getData();
  }

  searchFun(obj) {
    searchData = obj;
    param['curr_page'] = 1;
    if (searchData['goodsParam'].isEmpty) {
      param2.remove('goodsParam');
    } else {
      param2['goodsParam'] = jsonEncode(searchData['goodsParam']);
    }

    if (searchData['goodsParamExt'].isEmpty) {
      param2.remove('goodsParamExt');
    } else {
      param2['goodsParamExt'] = jsonEncode(searchData['goodsParamExt']);
    }

    if (searchData['goods']['goods_type'] == null) {
      param.remove('goods_type');
    } else {
      param['goods_type'] = searchData['goods']['goods_type'];
    }

    if (searchData['goods']['goods_class_id'] == null) {
      param.remove('goods_class_id');
    } else {
      param['goods_class_id'] = searchData['goods']['goods_class_id'];
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('商品搜索'),
        actions: <Widget>[Container()],
      ),
      endDrawer: Container(
        width: width * 0.7,
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: GoodsSearchDrawer(
          searchData: searchData,
          searchFun: searchFun,
          width: width,
          orgData: orgSearchDataParam,
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
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    width: width * 0.3,
                                    height: width * 0.3,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                            imageUrl: '$baseUrl${item['goods_url']}',
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
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            child: Text('${item['goods_type_name']}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: width * 0.3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            height: 36,
                                            child: Text(
                                              '${item['goods_name']}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: CFFontSize.title,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              double.tryParse(item['goods_price']) == 0
                                                  ? '免费'
                                                  : '¥${item['goods_price']}',
                                              style: TextStyle(
                                                color: Color(0xffff4400),
                                                fontSize: CFFontSize.title,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${item['shop_name']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: CFColors.gray,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.remove_red_eye,
                                                        size: 16,
                                                        color: CFColors.gray,
                                                      ),
                                                      Text(
                                                        ' ${item['browse_times']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: CFColors.gray,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 1,
                                                  height: 14,
                                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                                  color: CFColors.gray,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        size: 16,
                                                        color: CFColors.gray,
                                                      ),
                                                      Text(
                                                        ' ${item['sales_volume']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: CFColors.gray,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
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
