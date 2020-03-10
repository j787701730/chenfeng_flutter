import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GoodsClass extends StatefulWidget {
  @override
  _GoodsClassState createState() => _GoodsClassState();
}

class _GoodsClassState extends State<GoodsClass> {
  List goodsClass = [
    {
      "class_id": "1",
      "class_level": "1",
      "class_name": "设计模板",
      "class_sort": "10",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "101",
          "class_level": "2",
          "class_name": "全屋定制",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10101",
              "class_level": "3",
              "class_name": "橱柜",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10102",
              "class_level": "3",
              "class_name": "衣柜",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10103",
              "class_level": "3",
              "class_name": "更衣室",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10104",
              "class_level": "3",
              "class_name": "书柜",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10105",
              "class_level": "3",
              "class_name": "精品柜",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10106",
              "class_level": "3",
              "class_name": "装饰柜",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10107",
              "class_level": "3",
              "class_name": "护墙板",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10108",
              "class_level": "3",
              "class_name": "酒窖",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10109",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "9",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "102",
          "class_level": "2",
          "class_name": "定制部件",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10201",
              "class_level": "3",
              "class_name": "橱柜外框",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10202",
              "class_level": "3",
              "class_name": "衣柜外框",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10213",
              "class_level": "3",
              "class_name": "转角柜",
              "class_sort": "3",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10214",
              "class_level": "3",
              "class_name": "开放柜",
              "class_sort": "4",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10203",
              "class_level": "3",
              "class_name": "基础部件",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10211",
              "class_level": "3",
              "class_name": "榻榻米",
              "class_sort": "6",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10212",
              "class_level": "3",
              "class_name": "书桌",
              "class_sort": "7",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10204",
              "class_level": "3",
              "class_name": "抽屉",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10210",
              "class_level": "3",
              "class_name": "梁柱",
              "class_sort": "9",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10215",
              "class_level": "3",
              "class_name": "五金",
              "class_sort": "10",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10216",
              "class_level": "3",
              "class_name": "配件",
              "class_sort": "11",
              "class_pic_url": null,
              "children": ""
            },
            {
              "class_id": "10205",
              "class_level": "3",
              "class_name": "顶线",
              "class_sort": "12",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10206",
              "class_level": "3",
              "class_name": "罗马柱",
              "class_sort": "13",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10207",
              "class_level": "3",
              "class_name": "烟机罩",
              "class_sort": "14",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10208",
              "class_level": "3",
              "class_name": "装饰件",
              "class_sort": "15",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10209",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "99",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "103",
          "class_level": "2",
          "class_name": "成品家具",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10301",
              "class_level": "3",
              "class_name": "沙发",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10302",
              "class_level": "3",
              "class_name": "床铺",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10303",
              "class_level": "3",
              "class_name": "床头柜",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10304",
              "class_level": "3",
              "class_name": "茶几",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10305",
              "class_level": "3",
              "class_name": "电视柜",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10306",
              "class_level": "3",
              "class_name": "餐桌",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10307",
              "class_level": "3",
              "class_name": "椅子",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10308",
              "class_level": "3",
              "class_name": "斗柜",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10309",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "9",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "104",
          "class_level": "2",
          "class_name": "门",
          "class_sort": "4",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10401",
              "class_level": "3",
              "class_name": "移门",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10402",
              "class_level": "3",
              "class_name": "柜门",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10403",
              "class_level": "3",
              "class_name": "房门",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "105",
          "class_level": "2",
          "class_name": "电器",
          "class_sort": "5",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10501",
              "class_level": "3",
              "class_name": "橱房电器",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10502",
              "class_level": "3",
              "class_name": "家用电器",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10503",
              "class_level": "3",
              "class_name": "小家电",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "106",
          "class_level": "2",
          "class_name": "整装设计",
          "class_sort": "6",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10601",
              "class_level": "3",
              "class_name": "家装",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10602",
              "class_level": "3",
              "class_name": "公装",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "107",
          "class_level": "2",
          "class_name": "五金",
          "class_sort": "7",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10701",
              "class_level": "3",
              "class_name": "拉手",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10702",
              "class_level": "3",
              "class_name": "铰链",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10703",
              "class_level": "3",
              "class_name": "轨道",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10704",
              "class_level": "3",
              "class_name": "水槽",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10705",
              "class_level": "3",
              "class_name": "收纳",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10706",
              "class_level": "3",
              "class_name": "挂件",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10707",
              "class_level": "3",
              "class_name": "装饰",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "10708",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "108",
          "class_level": "2",
          "class_name": "其它",
          "class_sort": "8",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "10801",
              "class_level": "3",
              "class_name": "餐具",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            }
          ]
        }
      ]
    },
    {
      "class_id": "2",
      "class_level": "1",
      "class_name": "人工服务",
      "class_sort": "11",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "201",
          "class_level": "2",
          "class_name": "设计",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "20101",
              "class_level": "3",
              "class_name": "定制设计",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20102",
              "class_level": "3",
              "class_name": "家装设计",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20103",
              "class_level": "3",
              "class_name": "产品设计",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "202",
          "class_level": "2",
          "class_name": "施工",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "20201",
              "class_level": "3",
              "class_name": "泥工",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20202",
              "class_level": "3",
              "class_name": "水电工",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20203",
              "class_level": "3",
              "class_name": "木工",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20204",
              "class_level": "3",
              "class_name": "油漆工",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20205",
              "class_level": "3",
              "class_name": "安装工",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20206",
              "class_level": "3",
              "class_name": "杂工",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "203",
          "class_level": "2",
          "class_name": "物流",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "20301",
              "class_level": "3",
              "class_name": "配送",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20302",
              "class_level": "3",
              "class_name": "搬运",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "204",
          "class_level": "2",
          "class_name": "培训",
          "class_sort": "4",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "20401",
              "class_level": "3",
              "class_name": "设计师",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20402",
              "class_level": "3",
              "class_name": "技术工",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20403",
              "class_level": "3",
              "class_name": "销售",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20404",
              "class_level": "3",
              "class_name": "管理",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "20405",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            }
          ]
        }
      ]
    },
    {
      "class_id": "3",
      "class_level": "1",
      "class_name": "整体家居",
      "class_sort": "11",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "301",
          "class_level": "2",
          "class_name": "定制家具",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "30101",
              "class_level": "3",
              "class_name": "橱柜",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30102",
              "class_level": "3",
              "class_name": "衣柜",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30103",
              "class_level": "3",
              "class_name": "书柜",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30104",
              "class_level": "3",
              "class_name": "更衣室",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30105",
              "class_level": "3",
              "class_name": "精品柜",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30106",
              "class_level": "3",
              "class_name": "护墙板",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30107",
              "class_level": "3",
              "class_name": "酒窖",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30108",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30109",
              "class_level": "3",
              "class_name": "移门",
              "class_sort": "9",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "302",
          "class_level": "2",
          "class_name": "成品家具",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "30201",
              "class_level": "3",
              "class_name": "沙发",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30202",
              "class_level": "3",
              "class_name": "床铺",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30203",
              "class_level": "3",
              "class_name": "茶几",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30204",
              "class_level": "3",
              "class_name": "电视柜",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30205",
              "class_level": "3",
              "class_name": "餐椅",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30206",
              "class_level": "3",
              "class_name": "斗柜",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30207",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "303",
          "class_level": "2",
          "class_name": "办公家具",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "30301",
              "class_level": "3",
              "class_name": "办公桌椅",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30302",
              "class_level": "3",
              "class_name": "文件柜",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30303",
              "class_level": "3",
              "class_name": "办公沙发",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30304",
              "class_level": "3",
              "class_name": "屏风隔断",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "30305",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "307",
          "class_level": "2",
          "class_name": "其它家具",
          "class_sort": "7",
          "class_pic_url": "",
          "children": ""
        }
      ]
    },
    {
      "class_id": "5",
      "class_level": "1",
      "class_name": "装修材料",
      "class_sort": "13",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "501",
          "class_level": "2",
          "class_name": "基础材料",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50101",
              "class_level": "3",
              "class_name": "泥水",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50102",
              "class_level": "3",
              "class_name": "水路",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50103",
              "class_level": "3",
              "class_name": "电路",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50104",
              "class_level": "3",
              "class_name": "板材",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50105",
              "class_level": "3",
              "class_name": "油漆",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50106",
              "class_level": "3",
              "class_name": "辅材",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "502",
          "class_level": "2",
          "class_name": "装饰材料",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50201",
              "class_level": "3",
              "class_name": "磁砖",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50202",
              "class_level": "3",
              "class_name": "大理石",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50203",
              "class_level": "3",
              "class_name": "地板",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50204",
              "class_level": "3",
              "class_name": "墙纸",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50205",
              "class_level": "3",
              "class_name": "集成吊顶",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50207",
              "class_level": "3",
              "class_name": "门窗",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50208",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "503",
          "class_level": "2",
          "class_name": "五金",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50301",
              "class_level": "3",
              "class_name": "拉手",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50302",
              "class_level": "3",
              "class_name": "铰链",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50303",
              "class_level": "3",
              "class_name": "轨道",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50304",
              "class_level": "3",
              "class_name": "水槽",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50305",
              "class_level": "3",
              "class_name": "收纳",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50306",
              "class_level": "3",
              "class_name": "挂件",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50307",
              "class_level": "3",
              "class_name": "装饰",
              "class_sort": "7",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50308",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "8",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "504",
          "class_level": "2",
          "class_name": "洁具",
          "class_sort": "4",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50401",
              "class_level": "3",
              "class_name": "马桶",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50402",
              "class_level": "3",
              "class_name": "沐浴房",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50403",
              "class_level": "3",
              "class_name": "洗衣池",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50404",
              "class_level": "3",
              "class_name": "龙头",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50405",
              "class_level": "3",
              "class_name": "挂件",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50406",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "505",
          "class_level": "2",
          "class_name": "灯具",
          "class_sort": "5",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50501",
              "class_level": "3",
              "class_name": "开关面板",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50502",
              "class_level": "3",
              "class_name": "吊灯",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50503",
              "class_level": "3",
              "class_name": "台灯",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50504",
              "class_level": "3",
              "class_name": "其他",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "506",
          "class_level": "2",
          "class_name": "软装",
          "class_sort": "6",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "50601",
              "class_level": "3",
              "class_name": "布艺",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50602",
              "class_level": "3",
              "class_name": "摆饰",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "50603",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            }
          ]
        }
      ]
    },
    {
      "class_id": "8",
      "class_level": "1",
      "class_name": "电器设备",
      "class_sort": "16",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "801",
          "class_level": "2",
          "class_name": "橱房电器",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "80101",
              "class_level": "3",
              "class_name": "油烟机",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80102",
              "class_level": "3",
              "class_name": "灶具",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80103",
              "class_level": "3",
              "class_name": "消毒柜",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80104",
              "class_level": "3",
              "class_name": "烤箱",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80105",
              "class_level": "3",
              "class_name": "其它电器",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "802",
          "class_level": "2",
          "class_name": "家用电器",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "80201",
              "class_level": "3",
              "class_name": "电视",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80202",
              "class_level": "3",
              "class_name": "音响",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80203",
              "class_level": "3",
              "class_name": "冰箱",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80204",
              "class_level": "3",
              "class_name": "热水器",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80205",
              "class_level": "3",
              "class_name": "空调",
              "class_sort": "5",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80206",
              "class_level": "3",
              "class_name": "洗衣机",
              "class_sort": "6",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "803",
          "class_level": "2",
          "class_name": "小家电",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "80301",
              "class_level": "3",
              "class_name": "风扇",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80302",
              "class_level": "3",
              "class_name": "净化器",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80303",
              "class_level": "3",
              "class_name": "播放器",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "80304",
              "class_level": "3",
              "class_name": "其它",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "804",
          "class_level": "2",
          "class_name": "办公电器",
          "class_sort": "4",
          "class_pic_url": "",
          "children": ""
        },
        {
          "class_id": "805",
          "class_level": "2",
          "class_name": "其它",
          "class_sort": "5",
          "class_pic_url": "",
          "children": ""
        }
      ]
    },
    {
      "class_id": "9",
      "class_level": "1",
      "class_name": "生产设备",
      "class_sort": "17",
      "class_pic_url": "",
      "children": [
        {
          "class_id": "901",
          "class_level": "2",
          "class_name": "板式家具生产设备",
          "class_sort": "1",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "90101",
              "class_level": "3",
              "class_name": "开料机",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "90102",
              "class_level": "3",
              "class_name": "封边机",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "90103",
              "class_level": "3",
              "class_name": "侧孔钻",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "90104",
              "class_level": "3",
              "class_name": "CNC",
              "class_sort": "4",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "902",
          "class_level": "2",
          "class_name": "实木具生产设备",
          "class_sort": "2",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "90201",
              "class_level": "3",
              "class_name": "造型工具",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            }
          ]
        },
        {
          "class_id": "903",
          "class_level": "2",
          "class_name": "通用设备",
          "class_sort": "3",
          "class_pic_url": "",
          "children": [
            {
              "class_id": "90301",
              "class_level": "3",
              "class_name": "推台锯",
              "class_sort": "1",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "90302",
              "class_level": "3",
              "class_name": "空压机",
              "class_sort": "2",
              "class_pic_url": "",
              "children": ""
            },
            {
              "class_id": "90303",
              "class_level": "3",
              "class_name": "叉车",
              "class_sort": "3",
              "class_pic_url": "",
              "children": ""
            }
          ]
        }
      ]
    }
  ];
  PageController _pageController;
  int goodsClassIndex = 0;
  ScrollController _controllerView;
  bool scrollFlag = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controllerView = ScrollController();
    _controllerView.addListener(() {
//      print("滑动距离$offset");
      if (scrollFlag) {
        int offset = _controllerView.position.pixels.toInt();
        scrollFlag = false;
        const timeout = const Duration(milliseconds: 100);
        Timer(timeout, () {
          setState(() {
            scrollFlag = true;
          });
        });
        if (_controllerView.position.pixels > _controllerView.position.maxScrollExtent + 50) {
          if (goodsClassIndex < goodsClass.length - 1) {
            setState(() {
              goodsClassIndex = goodsClassIndex + 1;
              _pageController.animateToPage(goodsClassIndex,
                  duration: Duration(milliseconds: 50), curve: Curves.easeInOut);
            });
          }
        } else if (offset < -50) {
          if (goodsClassIndex != 0) {
            setState(() {
              goodsClassIndex = goodsClassIndex - 1;
              _pageController.animateToPage(goodsClassIndex,
                  duration: Duration(milliseconds: 50), curve: Curves.easeInOut);
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controllerView.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.all(
                Radius.circular(44),
              ),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: CFFontSize.content,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(
                  top: 6,
                  bottom: 6,
                  left: 15,
                ),
                hintText: '请输入关键字',
              ),
              onChanged: (val) {},
            ),
          ),
        ),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              color: Color(0xffeeeeee),
              child: ListView(
                children: goodsClass.map<Widget>(
                  (item) {
                    int index = goodsClass.indexOf(item);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          goodsClassIndex = index;
//                          _pageController.animateToPage(index,
//                              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                          _pageController.jumpToPage(index);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: goodsClassIndex == index ? CFColors.white : CFColors.transparent,
                        child: Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: goodsClassIndex == index ? Color(0xfffc4200) : CFColors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Text(
                            '${item['class_name']}',
                            style: TextStyle(
                              color: goodsClassIndex == index ? Color(0xfffc4200) : CFColors.text,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
//                physics: NeverScrollableScrollPhysics(), // 禁止左右滑动
                scrollDirection: Axis.vertical,
                children: goodsClass.map<Widget>(
                  (item) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        controller: _controllerView,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item['children'].map<Widget>(
                            (child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: width - 100,
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 6,
                                      top: 10,
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      '${child['class_name']}',
                                      style: TextStyle(color: Color(0xfffc4200), fontSize: CFFontSize.title),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xfffc4200),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child['children'] == ""
                                      ? Container()
                                      : Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: child['children'].map<Widget>(
                                            (child2) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                child: Text('${child2['class_name']}'),
                                              );
                                            },
                                          ).toList(),
                                        )
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  setState(() {
                    goodsClassIndex = index;
                  });
//                controller.animateTo(index); // 与TabBar的互动
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
