import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chenfengflutter/plugin/number_bar.dart';
import 'package:chenfengflutter/plugin/page_plugin.dart';
import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/style.dart';
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
    'markup_type': [],
    'markup_type': '',
    'markup_value': [],
    'evaluate_state': [],
    'task_time': []
  };
  List logs = [];
  int count = 0;
  BuildContext _context;
  ScrollController _controller;
  bool loading = true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

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

  getData({isRefresh: false}) async {
    //todo 搜索条件

    ajax('Tasks-getTasks', {'param': jsonEncode(param)}, true, (res) {
      if (mounted) {
        setState(() {
          logs = res['tasks'];
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('任务广场'),
      ),
      endDrawer: Container(
        width: width * 0.7,
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          '任务类型',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: taskType.keys.map<Widget>((item) {
                            return GestureDetector(
                              onTap: () {
                                if (searchData['task_type'].contains(item)) {
                                  setState(() {
                                    searchData['task_type'].remove(item);
                                  });
                                } else {
                                  setState(() {
                                    searchData['task_type'].add(item);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xfff5f5f5),
                                    border: Border.all(
                                      color: searchData['task_type'].contains(item)
                                          ? Color(0xffc40000)
                                          : Colors.transparent,
                                    ),
                                    image: DecorationImage(
                                      alignment: Alignment.bottomRight,
                                      image: AssetImage(
                                          searchData['task_type'].contains(item) ? 'assets/selected.png' : ''),
                                    )),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('${taskType[item]['type_ch_name']}'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '任务状态',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: taskState.keys.map<Widget>((item) {
                            return GestureDetector(
                              onTap: () {
                                if (searchData['state'].contains(item)) {
                                  setState(() {
                                    searchData['state'].remove(item);
                                  });
                                } else {
                                  setState(() {
                                    searchData['state'].add(item);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: searchData['state'].contains(item) ? Color(0xffc40000) : Colors.transparent,
                                  ),
                                  color: Color(0xfff5f5f5),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image: AssetImage(searchData['state'].contains(item) ? 'assets/selected.png' : ''),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('${taskState[item]['state_ch_name']}'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '需求时间',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: taskTime.map<Widget>((list) {
                            return GestureDetector(
                              onTap: () {
                                if (searchData['task_time'].contains(list)) {
                                  setState(() {
                                    searchData['task_time'].remove(list);
                                  });
                                } else {
                                  setState(() {
                                    searchData['task_time'].add(list);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  border: Border.all(
                                    color:
                                        searchData['task_time'].contains(list) ? Color(0xffc40000) : Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image:
                                        AssetImage(searchData['task_time'].contains(list) ? 'assets/selected.png' : ''),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('$list'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '加价类型',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: markupType.map<Widget>((list) {
                            return GestureDetector(
                              onTap: () {
                                if (searchData['markup_type'] == '') {
                                  setState(() {
                                    searchData['markup_type'] = list;
                                    searchData['markup_value'] = [];
                                  });
                                } else if (searchData['markup_type'] == list) {
                                  setState(() {
                                    searchData['markup_type'] = '';
                                    searchData['markup_value'] = [];
                                  });
                                } else {
                                  setState(() {
                                    searchData['markup_type'] = list;
                                    searchData['markup_value'] = [];
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  border: Border.all(
                                    color: searchData['markup_type'] == list ? Color(0xffc40000) : Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image: AssetImage(searchData['markup_type'] == list ? 'assets/selected.png' : ''),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('$list'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Offstage(
                        offstage: searchData['markup_type'] == '' || searchData['markup_type'] == '不加价',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '加价数值',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                            Offstage(
                              offstage: !(searchData['markup_type'] == '按比例加价'),
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: markupValue.map<Widget>((list) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (searchData['markup_value'].contains(list)) {
                                          searchData['markup_value'].remove(list);
                                        } else {
                                          searchData['markup_value'].add(list);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff5f5f5),
                                        border: Border.all(
                                          color: searchData['markup_value'].contains(list)
                                              ? Color(0xffc40000)
                                              : Colors.transparent,
                                        ),
                                        image: DecorationImage(
                                          alignment: Alignment.bottomRight,
                                          image: AssetImage(
                                              searchData['markup_value'].contains(list) ? 'assets/selected.png' : ''),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text('$list'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Offstage(
                              offstage: !(searchData['markup_type'] == '按固定额度'),
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: markupSearchLabel.map<Widget>((list) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (searchData['markup_value'].contains(list)) {
                                          searchData['markup_value'].remove(list);
                                        } else {
                                          searchData['markup_value'].add(list);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff5f5f5),
                                        border: Border.all(
                                          color: searchData['markup_value'].contains(list)
                                              ? Color(0xffc40000)
                                              : Colors.transparent,
                                        ),
                                        image: DecorationImage(
                                          alignment: Alignment.bottomRight,
                                          image: AssetImage(
                                              searchData['markup_value'].contains(list) ? 'assets/selected.png' : ''),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text('$list'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '评价状态',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: taskEvaluateState.keys.map<Widget>((list) {
                            return GestureDetector(
                              onTap: () {
                                if (searchData['evaluate_state'].contains(list)) {
                                  setState(() {
                                    searchData['evaluate_state'].remove(list);
                                  });
                                } else {
                                  setState(() {
                                    searchData['evaluate_state'].add(list);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  border: Border.all(
                                    color: searchData['evaluate_state'].contains(list)
                                        ? Color(0xffc40000)
                                        : Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image: AssetImage(
                                        searchData['evaluate_state'].contains(list) ? 'assets/selected.png' : ''),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('${taskEvaluateState[list]['state_ch_name']}'),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: width * 0.7,
                color: Colors.white,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      onPressed: () {
                        setState(() {
                          param['curr_page'] = 1;
                          getData();
                        });
                      },
                      child: Text('搜索'),
                    )
                  ],
                ),
              ),
            ),
          ],
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
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
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
                    : Column(
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
            Container(
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
