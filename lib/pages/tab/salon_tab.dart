import 'package:flutter/material.dart';
import 'package:salon/bloc/salon_bloc.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/utils/dialog_utils.dart';

class SalonTab extends StatefulWidget {
  @override
  SalonTabState createState() {
    return new SalonTabState();
  }
}

class SalonTabState extends State<SalonTab> with AutomaticKeepAliveClientMixin<SalonTab>{
  SalonBloc _bloc = new SalonBloc();

  @override
  void initState() {
    super.initState();
    _bloc.initData();
  }

 // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            child: StreamBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<List<PromotionItem>> snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(itemBuilder: (context,index)=>PromotionCard(snapshot.data.elementAt(index)),
                  );
                } else if (snapshot.hasError) { 
                  return Center(
                    child: Text("Some error..."),
                  );
                } else {
                  return DialogUtils.showCircularProgressBar();
                }
              },
              stream: _bloc.promotionList,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<List<SalonItem>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.9),
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    itemBuilder: (context, index) {
                      return SalonCard(snapshot.data.elementAt(index));
                    },
                    itemCount: snapshot.data.length,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Some error..."),
                  );
                } else {
                  return DialogUtils.showCircularProgressBar();
                }
              },
              stream: _bloc.salonList,
            ),
          ),
        ],
      ),
    );
  }
}

class SalonCard extends StatefulWidget {
  final SalonItem item;
  SalonCard(this.item);
  _SalonCardState createState() => _SalonCardState();
}

class _SalonCardState extends State<SalonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Image.network(
                widget.item.image,
                fit: BoxFit.fitHeight,
              )),
              // Expanded(
              //   child: Container(color: Colors.grey[300]),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.item.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      widget.item.address,
                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                    ),
                  ],
                ),
              ),

              //  Image.network(widget.item.Salon_u),
            ],
          ),
        ),
      ),
    );
  }

  String getTags(List<String> tags) {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeAll(tags.map((tag) => "#" + tag), " ");
    return stringBuffer.toString();
  }
}

class PromotionCard extends StatefulWidget {
  final PromotionItem item;
  PromotionCard(this.item);
  _PromotionCardState createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Image.network(
                widget.item.promotion_image,
                fit: BoxFit.fitWidth,
              )),
              // Expanded(
              //   child: Container(color: Colors.grey[300]),
              // ),

              //  Image.network(widget.item.Salon_u),
            ],
          ),
        ),
      ),
    );
  }
}
