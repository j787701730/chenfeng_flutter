import 'package:chenfengflutter/style.dart';
import 'package:chenfengflutter/utils.dart';
import 'package:chenfengflutter/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  final changeTabIndex;

  Home(this.changeTabIndex);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List topMenu = [
    {'img': 'Public/images/nav/cloud.png', 'name': '云拆单', 'color': 'F61D4B', 'url': '${baseUrl}Product'},
    {'img': 'Public/images/nav/task.png', 'name': '任务广场', 'color': '9231F4', 'route': '/tasks'},
    {'img': 'Public/images/nav/course.png', 'name': '软件教程', 'color': 'FF6D00', 'route': '/goodsClass'},
    {'img': 'Public/images/nav/community.png', 'name': '晨丰社区', 'color': '2C9DF7', 'route': '/goodsClass'},
    {'img': 'Public/images/nav/classify.png', 'name': '商品分类', 'color': '31ABA6', 'route': '/goodsClass'},
  ];

  List banner = [
    {'img': 'Public/images/home/num2/banner-01.jpg', 'url': "https://www.fzcfkj.com/"},
    {'img': 'Public/images/home/num2/banner-02.jpg', 'url': "https://www.fzcfkj.com/train"},
    {'img': 'Public/images/home/num2/banner-03.jpg', 'url': "https://www.fzcfkj.com/agent"},
    {'img': 'Public/images/home/num2/banner-04.jpg', 'url': "https://www.fzcfkj.com/"},
    {'img': "Public/images/index-2018/banner-01.jpg", 'url': "https://www.fzcfkj.com/"},
  ];

  List images = [
    'Public/images/index-2018/6_01.jpg',
    'Public/images/index-2018/6_02.jpg',
    'Public/images/index-2018/6_03.jpg',
    'Public/images/index-2018/6_04.jpg',
    'Public/images/index-2018/6_05.jpg',
    'Public/images/index-2018/6_06.jpg',
    'Public/images/index-2018/6_07.jpg',
    'Public/images/index-2018/6_08.jpg',
    'Public/images/index-2018/6_09.jpg',
    'Public/images/index-2018/6_10.jpg',
    'Public/images/index-2018/6_11.jpg',
    'Public/images/index-2018/6_12.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: topMenu.map<Widget>(
                      (item) {
                        return GestureDetector(
                          onTap: () {
                            if (item['route'] != null) {
                              if (item['route'] == '/goodsClass') {
                                this.widget.changeTabIndex(1);
                              } else {
                                Navigator.pushNamed(context, item['route']);
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: (width - 20) / 5 - 15,
                                  height: (width - 20) / 5 - 15,
                                  color: Color(int.tryParse(
                                      '0xff${int.tryParse('${item['color']}', radix: 16).toRadixString(16).toUpperCase()}')),
                                  child: CachedNetworkImage(
                                    imageUrl: '$baseUrl${item['img']}',
                                    placeholder: (context, url) => Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${item['name']}',
                                    style: TextStyle(
                                      fontSize: CFFontSize.content,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Container(
                  height: width * 750 / 1920,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        imageUrl: '$baseUrl${banner[index]['img']}',
                        placeholder: (context, url) => Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: banner.length,
                    pagination: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
                      return Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Wrap(
                          spacing: 10,
                          children: List.generate(config.itemCount, (int index) => index).map<Widget>(
                            (item) {
                              return Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: config.activeIndex == item ? Color(0xff90C0EF) : Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    }),
                    autoplay: true,
                    onTap: (idx) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebView(banner[idx]['url']),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: images.map<Widget>(
                    (item) {
                      return Container(
                        child: CachedNetworkImage(
                          imageUrl: '$baseUrl$item',
                          placeholder: (context, url) => Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
