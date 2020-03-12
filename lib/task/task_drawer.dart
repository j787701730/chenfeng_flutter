import 'package:chenfengflutter/plugin/input.dart';
import 'package:chenfengflutter/primary_button.dart';
import 'package:flutter/material.dart';

class TaskDrawer extends StatefulWidget {
  final searchData;
  final width;
  final searchFun;

  TaskDrawer({this.searchData, this.searchFun, this.width});

  @override
  _TaskDrawerState createState() => _TaskDrawerState();
}

class _TaskDrawerState extends State<TaskDrawer> {
//  Map searchData = {
//    'task_type': [],
//    'state': [],
//    'markup_type': '',
//    'markup_value': [],
//    'evaluate_state': [],
//    'task_time': [],
//    'orderNo': ''
//  };
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

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  Input(
                    label: '订单号',
                    labelWidth: 40,
                    value: widget.searchData['orderNo'],
                    onChanged: (String val) {
                      if (val.trim() == '') {
                        widget.searchData['orderNo'] = '';
                      } else {
                        widget.searchData['orderNo'] = val.trim();
                      }
                    },
                  ),
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
                            if (widget.searchData['task_type'].contains(item)) {
                              setState(() {
                                widget.searchData['task_type'].remove(item);
                              });
                            } else {
                              setState(() {
                                widget.searchData['task_type'].add(item);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                border: Border.all(
                                  color:
                                      widget.searchData['task_type'].contains(item) ? Color(0xffc40000) : Colors.transparent,
                                ),
                                image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image:
                                      AssetImage(widget.searchData['task_type'].contains(item) ? 'assets/selected.png' : ''),
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
                            if (widget.searchData['state'].contains(item)) {
                              setState(() {
                                widget.searchData['state'].remove(item);
                              });
                            } else {
                              setState(() {
                                widget.searchData['state'].add(item);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.searchData['state'].contains(item) ? Color(0xffc40000) : Colors.transparent,
                              ),
                              color: Color(0xfff5f5f5),
                              image: DecorationImage(
                                alignment: Alignment.bottomRight,
                                image: AssetImage(widget.searchData['state'].contains(item) ? 'assets/selected.png' : ''),
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
                            if (widget.searchData['task_time'].contains(list)) {
                              setState(() {
                                widget.searchData['task_time'].remove(list);
                              });
                            } else {
                              setState(() {
                                widget.searchData['task_time'].add(list);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              border: Border.all(
                                color: widget.searchData['task_time'].contains(list) ? Color(0xffc40000) : Colors.transparent,
                              ),
                              image: DecorationImage(
                                alignment: Alignment.bottomRight,
                                image: AssetImage(widget.searchData['task_time'].contains(list) ? 'assets/selected.png' : ''),
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
                            if (widget.searchData['markup_type'] == '') {
                              setState(() {
                                widget.searchData['markup_type'] = list;
                                widget.searchData['markup_value'] = [];
                              });
                            } else if (widget.searchData['markup_type'] == list) {
                              setState(() {
                                widget.searchData['markup_type'] = '';
                                widget.searchData['markup_value'] = [];
                              });
                            } else {
                              setState(() {
                                widget.searchData['markup_type'] = list;
                                widget.searchData['markup_value'] = [];
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              border: Border.all(
                                color: widget.searchData['markup_type'] == list ? Color(0xffc40000) : Colors.transparent,
                              ),
                              image: DecorationImage(
                                alignment: Alignment.bottomRight,
                                image: AssetImage(widget.searchData['markup_type'] == list ? 'assets/selected.png' : ''),
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
                    offstage: widget.searchData['markup_type'] == '' || widget.searchData['markup_type'] == '不加价',
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
                          offstage: !(widget.searchData['markup_type'] == '按比例加价'),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: markupValue.map<Widget>((list) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.searchData['markup_value'].contains(list)) {
                                      widget.searchData['markup_value'].remove(list);
                                    } else {
                                      widget.searchData['markup_value'].add(list);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f5f5),
                                    border: Border.all(
                                      color: widget.searchData['markup_value'].contains(list)
                                          ? Color(0xffc40000)
                                          : Colors.transparent,
                                    ),
                                    image: DecorationImage(
                                      alignment: Alignment.bottomRight,
                                      image: AssetImage(
                                          widget.searchData['markup_value'].contains(list) ? 'assets/selected.png' : ''),
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
                          offstage: !(widget.searchData['markup_type'] == '按固定额度'),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: markupSearchLabel.map<Widget>((list) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.searchData['markup_value'].contains(list)) {
                                      widget.searchData['markup_value'].remove(list);
                                    } else {
                                      widget.searchData['markup_value'].add(list);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f5f5),
                                    border: Border.all(
                                      color: widget.searchData['markup_value'].contains(list)
                                          ? Color(0xffc40000)
                                          : Colors.transparent,
                                    ),
                                    image: DecorationImage(
                                      alignment: Alignment.bottomRight,
                                      image: AssetImage(
                                          widget.searchData['markup_value'].contains(list) ? 'assets/selected.png' : ''),
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
                            if (widget.searchData['evaluate_state'].contains(list)) {
                              setState(() {
                                widget.searchData['evaluate_state'].remove(list);
                              });
                            } else {
                              setState(() {
                                widget.searchData['evaluate_state'].add(list);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              border: Border.all(
                                color: widget.searchData['evaluate_state'].contains(list)
                                    ? Color(0xffc40000)
                                    : Colors.transparent,
                              ),
                              image: DecorationImage(
                                alignment: Alignment.bottomRight,
                                image: AssetImage(
                                    widget.searchData['evaluate_state'].contains(list) ? 'assets/selected.png' : ''),
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
            width: widget.width * 0.7,
            color: Colors.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PrimaryButton(
                  onPressed: () {
                    setState(() {
                      widget.searchFun(widget.searchData);
                      Navigator.pop(context);
                    });
                  },
                  child: Text('搜索'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
