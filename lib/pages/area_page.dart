import 'package:flutter/material.dart';
import 'package:salon/bloc/area_bloc.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/data/model/area_model.dart';
import 'package:salon/pages/home_page.dart';
import 'package:salon/utils/dialog_utils.dart';

class AreaPage extends StatefulWidget {
  AreaPage();

  _AreaPageState createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  AreaBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = new AreaBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 64.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/location.png',
                  height: 24.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Select an Area :",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot<List<AreaItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                          child: Text(
                            "NEW DELHI",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Column(
                          children: snapshot.data
                              .map((item) => AreaWidget(
                                    item: item,
                                    callback: onAreaTap,
                                  ))
                              .toList(),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Some error..."),
                    );
                  } else {
                    return DialogUtils.showCircularProgressBar();
                  }
                },
                stream: _bloc.areaController,
              ),
            ),
          ),
        ],
      ),
      /*body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(4.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ProductCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.profileController,
      ),*/
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void onAreaTap(AreaItem item) {
    prefsHelper.selectedAreaName = item.location;
    prefsHelper.selectedAreaId = item.id;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}

class MenuItem extends StatelessWidget {
  final String title;

  MenuItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey[100]), bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

class WalletMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey[100]), bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text("DOT Wallet"),
        trailing: Container(
          height: 24.0,
          child: Text(
            "₹ 0",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
          decoration: BoxDecoration(color: Color(0xff64DD17), borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }
}

typedef void OnTapCallback(AreaItem item);

class AreaWidget extends StatelessWidget {
  final AreaItem item;

  final OnTapCallback callback;

  AreaWidget({@required this.item, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        elevation: 2.0,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              callback(item);
            },
            child: ListTile(
              title: Text(item.location),
              trailing: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
