import 'package:chenfengflutter/error.dart';
import 'package:chenfengflutter/goods/goods_class.dart';
import 'package:chenfengflutter/localizations.dart';
import 'package:chenfengflutter/login.dart';
import 'package:chenfengflutter/my_home_page.dart';
import 'package:chenfengflutter/task/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'style.dart';
import 'style.dart';
import 'style.dart';
import 'style.dart';
import 'style.dart';
import 'style.dart';
import 'style.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '晨丰爱家',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        textTheme: TextTheme(
          subhead: TextStyle(
            textBaseline: TextBaseline.alphabetic, // TextField hintText 居中
            fontSize: CFFontSize.content,
          ),
          body1: TextStyle(
            fontSize: CFFontSize.content,
            color: Color(0xff333333),
          ),
          button: TextStyle(
            fontSize: CFFontSize.content,
            color: Color(0xff333333),
          ),
        ),
        primaryColor: CFColors.primary,
        scaffoldBackgroundColor: Colors.white,
        primaryIconTheme: IconThemeData(
          color: CFColors.primary,
        ),
        iconTheme: IconThemeData(
          color: CFColors.primary,
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: CFFontSize.topTitle,
              color: CFColors.text,
            ),
          ),
          color: Colors.white,
        ),
        buttonTheme: ButtonThemeData(
          height: 30,
          minWidth: 56,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        cursorColor: CFColors.primary,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CFColors.primary,
            ),
          ),
          prefixStyle: TextStyle(
            color: CFColors.text,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (_) => MyHomePage(),
        '/login': (_) => Login(),
        '/goodsClass': (_) => GoodsClass(),
        '/tasks': (_) => Tasks(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 自己要补个文件 localizations.dart
        ChineseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => ErrorPage(),
      ),
    );
  }
}
