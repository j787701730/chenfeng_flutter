import 'dart:async';

import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/shop/shop_search.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chenfengflutter/goods/goods_search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map param = {
    'searchContent': '',
    'searchType': '1',
  };

  Map searchType = {
    '1': '商品',
    '2': '店铺',
    '3': '任务',
  };
  BuildContext _context;
  bool loading = false;
  List logs = [];
  bool scrollFlag = true;

  @override
  void initState() {
    super.initState();
    _context = context;
  }

  Timer timer;

  onChanged(String val) {
    setState(() {
      param['searchContent'] = val.trim();
    });
    if (timer != null) {
      timer.cancel();
    }
    const timeout = const Duration(milliseconds: 500);
    timer = Timer(timeout, () {
      getData();
    });
  }

  getData({isRefresh: false}) async {
    setState(() {
      loading = true;
    });
    ajaxSimple('Search-getKeywords', param, (res) {
//      print(res);
      if (mounted) {
        setState(() {
          logs = res ?? [];
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 30,
                  child: TextField(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: param['searchContent'],
                        selection: TextSelection.fromPosition(
                          TextPosition(affinity: TextAffinity.downstream, offset: param['searchContent'].length),
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: CFFontSize.content),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      hintText: '',
                    ),
                    maxLines: 1,
                    onChanged: (String val) {
                      onChanged(val);
                    },
                  ),
                ),
              ),
              PrimaryButton(
                onPressed: () {
                  if (param['searchType'] == '1') {
                    Navigator.push(
                      _context,
                      MaterialPageRoute(
                        builder: (context) => GoodsSearch(
                          goodsName: param['searchContent'],
                        ),
                      ),
                    );
                  } else if (param['searchType'] == '2') {
                    Navigator.push(
                      _context,
                      MaterialPageRoute(
                        builder: (context) => ShopSearch(
                          shopName: param['searchContent'],
                        ),
                      ),
                    );
                  }
                },
                child: Text('搜索'),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 40,
              child: Row(
                children: searchType.keys.map<Widget>((item) {
                  return Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            param['searchType'] = item;
                            logs.clear();
                            getData();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 4, top: 4),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: param['searchType'] == item ? Color(0xfffc4200) : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            '${searchType[item]}',
                            style: TextStyle(
                              fontSize: CFFontSize.title,
                              color: param['searchType'] == item ? Color(0xfffc4200) : CFColors.text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              child: loading
                  ? Container(
                      child: CupertinoActivityIndicator(),
                    )
                  : logs.isEmpty
                      ? Container(
                          alignment: Alignment.topCenter,
                          child: Text('无数据'),
                        )
                      : ListView(
                          children: ListTile.divideTiles(
                            tiles: logs.map((item) {
                              return ListTile(
                                onTap: () {
                                  if (param['searchType'] == '1') {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                        builder: (context) => GoodsSearch(
                                          goodsName: item['keywords'],
                                        ),
                                      ),
                                    );
                                  } else if (param['searchType'] == '2') {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                        builder: (context) => ShopSearch(
                                          shopName: item['keywords'],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                title: Text('${item['keywords']}'),
                              );
                            }).toList(),
                            context: context,
                          ).toList(),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
