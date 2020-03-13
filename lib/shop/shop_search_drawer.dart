import 'dart:convert';

import 'package:chenfengflutter/primary_button.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/material.dart';

class ShopSearchDrawer extends StatefulWidget {
  final searchData;
  final width;
  final searchFun;

  ShopSearchDrawer({
    this.searchData,
    this.searchFun,
    this.width,
  });

  @override
  _ShopSearchDrawerState createState() => _ShopSearchDrawerState();
}

class _ShopSearchDrawerState extends State<ShopSearchDrawer> {
  Map logs = {};
  bool loading = false;

  Map serviceType = {
    "11": {
      "service_type_id": "11",
      "service_type_en_name": "SERVICE_TYPE_MATERIAL_OBJECT",
      "service_type_ch_name": "实物商品交易",
      "assure_amount": "0.00",
      "comments": "具备实物类商品的发布、销售能力，如成品家具、定制家具、电器及装修材料等"
    },
    "12": {
      "service_type_id": "12",
      "service_type_en_name": "SERVICE_TYPE_FILE_FICTITIOUS",
      "service_type_ch_name": "虚拟商品交易",
      "assure_amount": "0.00",
      "comments": "具备虚拟类商品的发布、销售能力，如CAD设计模板文件等"
    },
    "13": {
      "service_type_id": "13",
      "service_type_en_name": "SERVICE_TYPE_DESIGN",
      "service_type_ch_name": "设计服务",
      "assure_amount": "0.00",
      "comments": "可提供定制设计、家装及产品设计能力"
    },
    "14": {
      "service_type_id": "14",
      "service_type_en_name": "SERVICE_TYPE_PRODUCTION",
      "service_type_ch_name": "生产加工",
      "assure_amount": "0.00",
      "comments": "可提供加工、生产能力"
    },
    "15": {
      "service_type_id": "15",
      "service_type_en_name": "SERVICE_TYPE_CONSTRUCTION",
      "service_type_ch_name": "施工服务",
      "assure_amount": "0.00",
      "comments": "可供工程施工服务，如安装工、水电工、杂工等"
    },
    "16": {
      "service_type_id": "16",
      "service_type_en_name": "SERVICE_TYPE_LOGISTICS",
      "service_type_ch_name": "物流服务",
      "assure_amount": "0.00",
      "comments": "提供物流配送、搬运等服务"
    },
    "17": {
      "service_type_id": "17",
      "service_type_en_name": "SERVICE_TYPE_TRAIN",
      "service_type_ch_name": "培训服务",
      "assure_amount": "0.00",
      "comments": "提供设计、技术、销售等的培训能力"
    }
  };

  Map role = {
    "101": {
      "role_id": "101",
      "role_en_name": "ROLE_TYPE_STORE",
      "role_ch_name": "销售门店",
      "can_apply": "1",
      "comments": "提供全方位的销售定制门店",
      "icon": "icon-shopping-cart"
    },
    "102": {
      "role_id": "102",
      "role_en_name": "ROLE_TYPE_SUPPLIER",
      "role_ch_name": "供货商",
      "can_apply": "1",
      "comments": "提供五金建材的供货服务",
      "icon": "icon-truck"
    },
    "103": {
      "role_id": "103",
      "role_en_name": "ROLE_TYPE_FACTORY",
      "role_ch_name": "加工工厂",
      "can_apply": "1",
      "comments": "提供定价加工服务",
      "icon": "icon-gears"
    },
    "104": {
      "role_id": "104",
      "role_en_name": "ROLE_TYPE_DESIGNER",
      "role_ch_name": "设计师",
      "can_apply": "1",
      "comments": "提供设计、测量等服务",
      "icon": "icon-male"
    },
    "105": {
      "role_id": "105",
      "role_en_name": "ROLE_TYPE_CONSTRUCTION",
      "role_ch_name": "工程施工",
      "can_apply": "1",
      "comments": "提供上门施工服务",
      "icon": "icon-wrench"
    }
  };

  @override
  void initState() {
    super.initState();
    getData();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          '服务提供',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: serviceType.keys.map<Widget>((key) {
                            bool selected = widget.searchData['service_type'].contains(key);
                            return GestureDetector(
                              onTap: () {
                                if (selected) {
                                  widget.searchData['service_type'].remove(key);
                                } else {
                                  widget.searchData['service_type'].add(key);
                                }
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  border: Border.all(
                                    color: selected ? Color(0xffc40000) : Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image:
                                        selected ? AssetImage('assets/selected.png') : AssetImage('assets/empty.png'),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('${serviceType[key]['service_type_ch_name']}'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        child: Text(
                          '店铺角色',
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: role.keys.map<Widget>((key) {
                            bool selected = widget.searchData['user_role'].contains(key);
                            return GestureDetector(
                              onTap: () {
                                if (selected) {
                                  widget.searchData['user_role'].remove(key);
                                } else {
                                  widget.searchData['user_role'].add(key);
                                }
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  border: Border.all(
                                    color: selected ? Color(0xffc40000) : Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.bottomRight,
                                    image:
                                        selected ? AssetImage('assets/selected.png') : AssetImage('assets/empty.png'),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 10,
                                ),
                                child: Text('${role[key]['role_ch_name']}'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
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
