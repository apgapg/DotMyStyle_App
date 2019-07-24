import 'package:flutter/material.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/pages/product_page.dart';
import 'package:salon/pages/profile_page.dart';
import 'package:salon/pages/tab/inspiration_tab.dart';
import 'package:salon/pages/tab/salon_tab.dart';
import 'package:salon/widget/bottom_bar_item.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabController _tabController;

  final List<String> _bottomBarItemList = [
    /*"Feeds",*/ "Explore",
    "Products",
    "Inspiration"
  ];
  final List<IconData> _bottomBarItemIconList = [
    // Icons.rss_feed,
    Icons.search,
    Icons.rss_feed,
    Icons.rss_feed,
  ];
  final List<Widget> _pageList = [
    //FeedTab(),
    SalonTab(),
    ProductListTab(),
    InspirationTab(),
  ];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    print("Token: " + prefsHelper.token);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(
          "DotMyStyle",
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: onProfilePress,
          )
        ],
      ),*/
      body: _pageList.elementAt(_selectedPageIndex),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 44.0,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _bottomBarItemList
                .map(
                  (item) => BottomBarItem(
                      item,
                      _selectedPageIndex == _bottomBarItemList.indexOf(item),
                      _bottomBarItemIconList.elementAt(
                        _bottomBarItemList.indexOf(item),
                      ),
                      onBottomBarItemTap),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void onBottomBarItemTap(String item) {
    setState(() {
      _selectedPageIndex = _bottomBarItemList.indexOf(item);
    });
  }

  void onProfilePress() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ProfilePage(),
        ));
  }
}
