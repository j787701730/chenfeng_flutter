import 'dart:convert';

import 'package:chenfengflutter/goods/goods_class.dart';
import 'package:chenfengflutter/goods/shop_cart.dart';
import 'package:chenfengflutter/login.dart';
import 'package:chenfengflutter/menu_data.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:chenfengflutter/webview.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chenfengflutter/home.dart';

import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List menu = [];
  String searchStr = '';
  bool isLogin = false;
  bool isAjax = true;
  DateTime _lastPressedAt; // 上次点击时间
  BuildContext _context;
  List access = [];
  int _tabIndex = 0;
  List list = [];

  @override
  void initState() {
    super.initState();
    menu = jsonDecode(jsonEncode(menuData));
    _context = context;
//    getAccess();
    list = [
      Home(changeTabIndex),
      GoodsClass(),
      ShopCart(),
      WebView('${baseUrl}Article-4'),
      Login(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void countDown() {
    // 设置倒计时三秒后执行跳转方法
    Duration duration = Duration(seconds: 1);
    setState(() {
      isAjax = false;
    });
    Future.delayed(duration, checkLogin);
  }

  getAccess() async {
    ajaxSimple('Adminrelas-Manage-getTest', {}, (res) {
      setState(() {
        isAjax = false;
      });
      if (res.runtimeType != String && res['err_code'] == 0) {
        setState(() {
          isLogin = true;
          access = res['data'];
        });
      } else {
        checkLogin();
      }
    }, netError: (val) {
      setState(() {
        isAjax = false;
      });
    });
  }

  checkLogin() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  changeTabIndex(inx) {
    setState(() {
      _tabIndex = inx;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _context = context;
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
          msg: '再按一次退出app',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          // 两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: list[_tabIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 1,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Color(0xffF03726),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              title: Text(
                '首页',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('分类'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('购物车'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('软件教程'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('更多'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          onTap: (val) {
            setState(() {
              _tabIndex = val;
            });
          },
        ),
      ),
    );
  }
}
