import 'package:chenfengflutter/error.dart';
import 'package:chenfengflutter/goods/goods_class.dart';
import 'package:chenfengflutter/localizations.dart';
import 'package:chenfengflutter/login.dart';
import 'package:chenfengflutter/my_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          ),
        ),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 1),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (_) => MyHomePage(),
        '/login': (_) => Login(),
        '/goodsClass': (_) => GoodsClass(),
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
