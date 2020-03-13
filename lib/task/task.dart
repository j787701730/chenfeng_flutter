import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chenfengflutter/plugin/number_bar.dart';
import 'package:chenfengflutter/plugin/page_plugin.dart';
import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/task/task_drawer.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  Map param = {'curr_page': 1, 'page_count': 20};
  Map searchData = {
    'task_type': [],
    'state': [],
    'markup_type': '',
    'markup_value': [],
    'evaluate_state': [],
    'task_time': [],
    'orderNo': ''
  };
  String orderNo = '';
  String order = 'create_date desc';
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
    Timer(Duration(milliseconds: 200), () {
      getData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  getDate(id) {
    DateTime myDate = new DateTime.now();
    switch (id) {
      case 0:
        break;
      case 1:
        myDate = myDate.subtract(Duration(days: 1));
        break;
      case 2:
        myDate = myDate.subtract(Duration(days: 2));
        break;
      case 3:
        myDate = myDate.subtract(Duration(days: 6));
        break;
      case 4:
        break;
      case 5:
        myDate = myDate.add(Duration(days: 1));
        break;
      case 6:
        myDate = myDate.add(Duration(days: 2));
        break;
      case 7:
        myDate = myDate.add(Duration(days: 6));
        break;
      default:
    }
    return '${myDate.year}-${myDate.month}-${myDate.day}';
  }

  getData({isRefresh: false}) async {
    searchData.forEach((k, v) {
      if (k == 'task_type' || k == 'state' || k == 'evaluate_state') {
        if (v.isEmpty) {
          param.remove(k);
        } else {
          param[k] = v.join(',');
        }
      } else if (k == 'markup_type') {
        if (v == '') {
          param.remove('markup_type');
          param.remove('markup_value');
        } else {
          param['markup_type'] = markupType.indexOf(v);
          if (markupType.indexOf(v) == 1) {
            if (searchData['markup_value'].isEmpty) {
              param.remove('markup_value');
            } else {
              param['markup_value'] = searchData['markup_value'].join(',');
            }
          } else if (markupType.indexOf(v) == 2) {
            if (searchData['markup_value'].isEmpty) {
              param.remove('markup_value');
            } else {
              param['markup_value'] = [];
              searchData['markup_value'].forEach((v) {
                int index = markupSearchLabel.indexOf(v);
                param['markup_value'].add({
                  "markup_valueL": markupSearchValue[index][0],
                  "markup_valueU": markupSearchValue[index][1],
                });
              });
            }
          }
        }
      } else if (k == 'task_time') {
        if (v.isEmpty) {
          param.remove('create_dateL');
          param.remove('end_date');
        } else {
          int min;
          int max;
          v.forEach((time) {
            int index2 = taskTime.indexOf(time);
            if (index2 > -1 && index2 < 4) {
              min = index2;
              if (min < index2) {
                min = index2;
              }
            } else if (index2 > 3) {
              max = index2;
              if (max < index2) {
                max = index2;
              }
            }
          });
          if (min == null) {
            param.remove('create_dateL');
          } else {
            param['create_dateL'] = getDate(min);
          }
          if (max == null) {
            param.remove('end_date');
          } else {
            param['end_date'] = getDate(max);
          }
        }
      }
    });
    ajax('Tasks-getTasks', {'param': jsonEncode(param)}, true, (res) {
      if (mounted) {
        setState(() {
          logs = res['tasks'] ?? [];
          count = int.tryParse('${res['count'] ?? 0}');
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

  Map taskType = {
    '104': {'type_ch_name': '设计任务'}
  };
  Map taskState = {
    "1": {"state_id": "1", "state_en_name": "TASK_STATE_WAIT_RECV", "state_ch_name": "待接单"},
    "2": {"state_id": "2", "state_en_name": "TASK_STATE_ING", "state_ch_name": "进行中"},
    "3": {"state_id": "3", "state_en_name": "TASK_STATE_WAIT_CONFIRM", "state_ch_name": "已完成待确认"},
    "4": {"state_id": "4", "state_en_name": "TASK_STATE_PROBLEM", "state_ch_name": "问题处理中"},
    "5": {"state_id": "5", "state_en_name": "TASK_STATE_OVER", "state_ch_name": "任务结束"},
    "6": {"state_id": "6", "state_en_name": "TASK_STATE_CANCEL", "state_ch_name": "已取消"}
  };
  List markupType = ["不加价", "按比例加价", "按固定额度"];
  List markupValue = [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2];
  List taskTime = ["今日发布", "近两日发布", "近3天发布", "近7天发布", "今日之前到期", "明日之前到期", "3天内到期", "7天内到期"];

  List markupSearchLabel = ["1-10元", "11-20元", "21-50元", "51-100元", "101-200元", "201-500元", "500元以上"];
  List markupSearchValue = [
    [1, 10],
    [11, 20],
    [21, 50],
    [51, 100],
    [101, 200],
    [201, 500],
    [501, 99999999]
  ];

  Map taskEvaluateState = {
    "1": {"state_id": "1", "state_en_name": "TASK_EVALUATE_STATE_NEW", "state_ch_name": "待评价"},
    "2": {"state_id": "2", "state_en_name": "TASK_EVALUATE_STATE_DEPLOYER", "state_ch_name": "发布人已评"},
    "3": {"state_id": "3", "state_en_name": "TASK_EVALUATE_STATE_RECEIVER", "state_ch_name": "接单人已评"},
    "4": {"state_id": "4", "state_en_name": "TASK_EVALUATE_STATE_ALL", "state_ch_name": "双方已评"}
  };

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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('任务广场'),
        actions: <Widget>[Container()],
      ),
      endDrawer: Container(
        width: width * 0.7,
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: TaskDrawer(
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
                        orderBy('create_date desc');
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '最新',
                                style: TextStyle(
                                  color: order == 'create_date desc' ? Color(0xffb10000) : CFColors.text,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: order == 'create_date desc' ? Color(0xffb10000) : CFColors.text,
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
                        orderBy('end_date desc');
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '快结束',
                                style: TextStyle(
                                  color: order == 'end_date desc' ? Color(0xffb10000) : CFColors.text,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: order == 'end_date desc' ? Color(0xffb10000) : CFColors.text,
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
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffdddddd),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        item['top'] == '1'
                                            ? TextSpan(
                                                text: '置顶',
                                                style: TextStyle(
                                                  background: Paint()..color = Color(0xfffd5647),
                                                  color: Colors.white,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                              ),
                                        TextSpan(
                                          text: item['top'] == '1' && item['anonymous'] == '1' ? ' ' : '',
                                        ),
                                        item['anonymous'] == '1'
                                            ? TextSpan(
                                                text: '匿名',
                                                style: TextStyle(
                                                  background: Paint()..color = Color(0xffff9400),
                                                  color: Colors.white,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                              ),
                                        TextSpan(
                                          text: ' ${item['task_name']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0b73bb),
                                          ),
                                        ),
                                      ],
                                      style: TextStyle(
                                        color: CFColors.text,
                                        fontSize: CFFontSize.content,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 3),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 2),
                                                  child: Text('订单单号：${item['order_no']}'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 2),
                                                  child: Text('任务类型：${item['type_ch_name']}'),
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 2),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: 24,
                                                          height: 24,
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
                                                        Expanded(child: Text(' ${item['shop_name']}'))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 3),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 2),
                                                  child: Text('${item['state_ch_name']}'),
                                                ),
                                                item['markup_type'] == '1'
                                                    ? Container(
                                                        margin: EdgeInsets.only(bottom: 2),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: '${item['markup_value']}',
                                                                style: TextStyle(
                                                                  color: Color(0xfff76812),
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: '倍加价',
                                                              ),
                                                            ],
                                                            style: TextStyle(
                                                              color: CFColors.text,
                                                              fontSize: CFFontSize.content,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : item['markup_type'] == '2'
                                                        ? Container(
                                                            margin: EdgeInsets.only(bottom: 2),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: '加价',
                                                                  ),
                                                                  TextSpan(
                                                                    text: '${item['markup_value']}',
                                                                    style: TextStyle(
                                                                      color: Color(0xfff76812),
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: '元',
                                                                  ),
                                                                ],
                                                                style: TextStyle(
                                                                  color: CFColors.text,
                                                                  fontSize: CFFontSize.content,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 2),
                                                  child: Text('${item['create_date']} 创建'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 2),
                                                  child: Text('${item['start_date']} 开始'),
                                                ),
                                                Container(
                                                  child: Text('${item['end_date']} 截止'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
