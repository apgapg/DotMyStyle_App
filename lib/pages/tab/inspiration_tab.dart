import 'package:flutter/material.dart';
import 'package:salon/bloc/inpiration_bloc.dart';
import 'package:salon/bloc/provider.dart';
import 'package:salon/data/model/inspiraton_model.dart';
import 'package:salon/utils/dialog_utils.dart';

class InspirationTab extends StatefulWidget {
  @override
  InspirationTabState createState() {
    return new InspirationTabState();
  }
}

class InspirationTabState extends State<InspirationTab> with AutomaticKeepAliveClientMixin<InspirationTab> {
  InspirationBloc _bloc = new InspirationBloc();

  @override
  void initState() {
    super.initState();
    _bloc.initData();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      bloc: _bloc,
      child: Container(
        child: StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<InspirationItem>> snapshot) {
            if (snapshot.hasData) {
              List<InspirationItem> itemList = snapshot.data;
              List<Widget> childrenWidget = new List();
              List<String> list = snapshot.data.map((item) => item.category).toSet().toList();
              for (int i = 0; i < list.length; i++) {
                childrenWidget.add(SliverList(
                  delegate: SliverChildListDelegate([HeaderWidget(list.elementAt(i))]),
                ));
                var _list = itemList.where((item) => item.category == list.elementAt(i));
                childrenWidget.add(SliverPadding(
                  padding: const EdgeInsets.all(4.0),
                  sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                              (context, i) =>
                          new GridTile(
                            child: new InspirationCard(_list.elementAt(i)),
                          ),
                          childCount: _list.length),
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9)),
                ));
              }
              return CustomScrollView(
                slivers: childrenWidget,
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Some error..."),
              );
            } else {
              return DialogUtils.showCircularProgressBar();
            }
          },
          stream: _bloc.list,
        ),
      ),
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class HeaderWidget extends StatelessWidget {
  final String title;

  HeaderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey[900], fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class InspirationCard extends StatefulWidget {
  final InspirationItem item;

  InspirationCard(this.item);

  _InspirationCardState createState() => _InspirationCardState();
}

class _InspirationCardState extends State<InspirationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Image.network(
              widget.item.url,
              fit: BoxFit.fitHeight,
            )),
            // Expanded(
            //   child: Container(color: Colors.grey[300]),
            // ),

            //  Image.network(widget.item.Salon_u),
          ],
        ),
      ),
    );
  }
}
