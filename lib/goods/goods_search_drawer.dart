import 'dart:convert';

import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/material.dart';

class GoodsSearchDrawer extends StatefulWidget {
  final searchData;
  final width;
  final searchFun;
  final orgData;

  GoodsSearchDrawer({
    this.searchData,
    this.searchFun,
    this.width,
    this.orgData,
  });

  @override
  _GoodsSearchDrawerState createState() => _GoodsSearchDrawerState();
}

class _GoodsSearchDrawerState extends State<GoodsSearchDrawer> {
  Map logs = {};
  bool loading = false;

  @override
  void initState() {
    super.initState();
//    getData();
  }

  getData({isRefresh: false}) async {
    setState(() {
      loading = true;
    });
    Map temp = jsonDecode(jsonEncode(widget.searchData));
    temp['goods'] = jsonEncode(temp['goods']);
    ajaxSimple('GoodsSearch-getSearchParam', temp, (res) {
      if (mounted) {
        setState(() {
          logs = res.isEmpty ? {} : res;
          loading = false;
        });
      }
    });
  }

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
                  widget.orgData.isNotEmpty && widget.orgData['goods_class'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                '分类',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                            Container(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: widget.orgData['goods_class'].map<Widget>((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (widget.searchData['goods']['goods_class_id'] != null) {
                                        List goodsClassId = widget.searchData['goods']['goods_class_id'].split(',');
                                        if (goodsClassId.contains(item['class_id'])) {
                                          goodsClassId.remove(item['class_id']);
                                        } else {
                                          goodsClassId.add(item['class_id']);
                                        }
                                        if (goodsClassId.isEmpty) {
                                          widget.searchData['goods'].remove('goods_class_id');
                                        } else {
                                          widget.searchData['goods']['goods_class_id'] = goodsClassId.join(',');
                                        }
                                      } else {
                                        widget.searchData['goods']['goods_class_id'] = item['class_id'];
                                      }
//                                      getData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff5f5f5),
                                        border: Border.all(
                                          color: widget.searchData['goods']['goods_class_id'] != null &&
                                                  widget.searchData['goods']['goods_class_id']
                                                      .contains(item['class_id'])
                                              ? Color(0xffc40000)
                                              : Colors.transparent,
                                        ),
                                        image: DecorationImage(
                                          alignment: Alignment.bottomRight,
                                          image: widget.searchData['goods']['goods_class_id'] != null &&
                                                  widget.searchData['goods']['goods_class_id']
                                                      .contains(item['class_id'])
                                              ? AssetImage('assets/selected.png')
                                              : AssetImage('assets/empty.png'),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text('${item['class_name']}'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  widget.orgData.isNotEmpty && widget.orgData['goods_type'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 8, top: 8),
                              child: Text(
                                '商品类型',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                            Container(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: widget.orgData['goods_type'].keys.map<Widget>((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (widget.searchData['goods']['goods_type'] != null) {
                                        List goodsClassId = widget.searchData['goods']['goods_type'].split(',');
                                        if (goodsClassId
                                            .contains(widget.orgData['goods_type'][item]['goods_type_id'])) {
                                          goodsClassId.remove(widget.orgData['goods_type'][item]['goods_type_id']);
                                        } else {
                                          goodsClassId.add(widget.orgData['goods_type'][item]['goods_type_id']);
                                        }
                                        if (goodsClassId.isEmpty) {
                                          widget.searchData['goods'].remove('goods_type');
                                        } else {
                                          widget.searchData['goods']['goods_type'] = goodsClassId.join(',');
                                        }
                                      } else {
                                        widget.searchData['goods']['goods_type'] =
                                            widget.orgData['goods_type'][item]['goods_type_id'];
                                      }
//                                      getData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff5f5f5),
                                        border: Border.all(
                                          color: widget.searchData['goods']['goods_type'] != null &&
                                                  widget.searchData['goods']['goods_type']
                                                      .contains(widget.orgData['goods_type'][item]['goods_type_id'])
                                              ? Color(0xffc40000)
                                              : Colors.transparent,
                                        ),
                                        image: DecorationImage(
                                          alignment: Alignment.bottomRight,
                                          image: widget.searchData['goods']['goods_type'] != null &&
                                                  widget.searchData['goods']['goods_type']
                                                      .contains(widget.orgData['goods_type'][item]['goods_type_id'])
                                              ? AssetImage('assets/selected.png')
                                              : AssetImage('assets/empty.png'),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text('${widget.orgData['goods_type'][item]['goods_type_ch_name']}'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  widget.orgData.isNotEmpty && widget.orgData['goodsParam'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.orgData['goodsParam'].keys.map<Widget>((item) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 8, top: 8),
                                  child: Text(
                                    '${widget.orgData['goodsParam'][item]['param_name']}',
                                    style: TextStyle(
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: widget.orgData['goodsParam'][item]['param_value'].map<Widget>((value) {
                                      bool selected = false;
                                      for (var i = 0; i < widget.searchData['goodsParam'].length; i++) {
                                        if (widget.orgData['goodsParam'][item]['param_id'] ==
                                            widget.searchData['goodsParam'][i]['param_id']) {
                                          List arr = widget.searchData['goodsParam'][i]['param_value'].split(',');
                                          if (arr.contains(value)) {
                                            selected = true;
                                          }
                                          break;
                                        }
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          if (widget.searchData['goodsParam'].isEmpty) {
                                            widget.searchData['goodsParam'].add({
                                              'param_id': widget.orgData['goodsParam'][item]['param_id'],
                                              'param_value': value
                                            });
                                          } else {
                                            for (var i = 0; i < widget.searchData['goodsParam'].length; i++) {
                                              if (widget.orgData['goodsParam'][item]['param_id'] ==
                                                  widget.searchData['goodsParam'][i]['param_id']) {
                                                List arr = widget.searchData['goodsParam'][i]['param_value'].split(',');
                                                if (arr.contains(value)) {
                                                  arr.remove(value);
                                                } else {
                                                  arr.add(value);
                                                }
                                                if (arr.isEmpty) {
                                                  widget.searchData['goodsParam'].removeAt(i);
                                                } else {
                                                  widget.searchData['goodsParam'][i]['param_value'] = arr.join(',');
                                                }
                                                break;
                                              }
                                              if (i == widget.searchData['goodsParam'].length - 1) {
                                                widget.searchData['goodsParam'].add({
                                                  'param_id': widget.orgData['goodsParam'][item]['param_id'],
                                                  'param_value': value
                                                });
                                                break;
                                              }
                                            }
                                          }
                                          setState(() {});
//                                          getData();
                                        },
                                        child: Container(
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: Color(0xfff5f5f5),
                                            border: Border.all(
                                              color: selected ? Color(0xffc40000) : Colors.transparent,
                                            ),
                                            image: DecorationImage(
                                              alignment: Alignment.bottomRight,
                                              image: selected
                                                  ? AssetImage('assets/selected.png')
                                                  : AssetImage('assets/empty.png'),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 10,
                                          ),
                                          child: Text('$value'),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        )
                      : Container(),
                  widget.orgData.isNotEmpty && widget.orgData['goodsParamExt'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.orgData['goodsParamExt'].keys.map<Widget>((item) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 8, top: 8),
                                  child: Text(
                                    '${widget.orgData['goodsParamExt'][item]['param_name']}',
                                    style: TextStyle(
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: widget.orgData['goodsParamExt'][item]['param_value'].map<Widget>((value) {
                                      bool selected = false;
                                      for (var i = 0; i < widget.searchData['goodsParamExt'].length; i++) {
                                        if (widget.orgData['goodsParamExt'][item]['param_id'] ==
                                            widget.searchData['goodsParamExt'][i]['param_id']) {
                                          for (var j = 0;
                                              j < widget.searchData['goodsParamExt'][i]['param_ext'].length;
                                              j++) {
                                            if (widget.searchData['goodsParamExt'][i]['param_ext'][j]['left_value'] ==
                                                value['left_value']) {
                                              selected = true;
                                              break;
                                            }
                                          }
                                          break;
                                        }
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          if (widget.searchData['goodsParamExt'].isEmpty) {
                                            widget.searchData['goodsParamExt'].add({
                                              'param_id': widget.orgData['goodsParamExt'][item]['param_id'],
                                              'param_ext': [
                                                {"left_value": value['left_value'], "right_value": value['right_value']}
                                              ]
                                            });
                                          } else {
                                            for (var i = 0; i < widget.searchData['goodsParamExt'].length; i++) {
                                              if (widget.orgData['goodsParamExt'][item]['param_id'] ==
                                                  widget.searchData['goodsParamExt'][i]['param_id']) {
                                                List arr = widget.searchData['goodsParamExt'][i]['param_ext'];
                                                for (var j = 0; j < arr.length; j++) {
                                                  if (arr[j]['left_value'] == value['left_value']) {
                                                    arr.removeAt(j);
                                                    break;
                                                  }
                                                  if (j == arr.length - 1) {
                                                    arr.add({
                                                      "left_value": value['left_value'],
                                                      "right_value": value['right_value']
                                                    });
                                                    break;
                                                  }
                                                }
                                                if (arr.isEmpty) {
                                                  widget.searchData['goodsParamExt'].removeAt(i);
                                                } else {
                                                  widget.searchData['goodsParamExt'][i]['param_value'] = arr;
                                                }
                                                break;
                                              }
                                              if (i == widget.searchData['goodsParamExt'].length - 1) {
                                                widget.searchData['goodsParamExt'].add({
                                                  'param_id': widget.orgData['goodsParamExt'][item]['param_id'],
                                                  'param_ext': [
                                                    {
                                                      "left_value": value['left_value'],
                                                      "right_value": value['right_value']
                                                    }
                                                  ]
                                                });
                                                break;
                                              }
                                            }
                                          }
                                          setState(() {});
//                                          getData();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xfff5f5f5),
                                            border: Border.all(
                                              color: selected ? Color(0xffc40000) : Colors.transparent,
                                            ),
                                            image: DecorationImage(
                                              alignment: Alignment.bottomRight,
                                              image: selected
                                                  ? AssetImage('assets/selected.png')
                                                  : AssetImage('assets/empty.png'),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 10,
                                          ),
                                          child: Text('${value['value_desc']}'),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        )
                      : Container(),
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
