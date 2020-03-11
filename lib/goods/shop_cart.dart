import 'package:cached_network_image/cached_network_image.dart';
import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:flutter/material.dart';

class ShopCart extends StatefulWidget {
  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: '${baseUrl}Public/images/shopcart.png',
                placeholder: (context, url) => Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.only(
                right: 10,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '您的购物车还是空的，赶紧行动吧！您可以：',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      bottom: 15,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text('看看'),
                      Text(
                        '我的收藏',
                        style: TextStyle(
                          color: CFColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('看看'),
                      Text(
                        '已买到的宝贝',
                        style: TextStyle(
                          color: CFColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
