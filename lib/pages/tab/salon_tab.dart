import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salon/bloc/salon_bloc.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/pages/salon_detail_page.dart';
import 'package:salon/utils/dialog_utils.dart';

class SalonTab extends StatefulWidget {
  @override
  SalonTabState createState() {
    return new SalonTabState();
  }
}

class SalonTabState extends State<SalonTab>
    with AutomaticKeepAliveClientMixin<SalonTab> {
  final _bloc = new SalonBloc();
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

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
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<SalonItem>> snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.all(2.0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      Container(
                        height: 200.0,
                        child: StreamBuilder(
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PromotionItem>> snapshot) {
                            if (snapshot.hasData) {
                              return Stack(
                                children: <Widget>[
                                  PageView.builder(
                                    controller: _controller,
                                    itemBuilder: (context, index) =>
                                        PromotionCard(
                                            snapshot.data.elementAt(index)),
                                  ),
                                  new Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: new Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Colors.transparent,
                                            Colors.black38
                                          ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter)),
                                      child: new Center(
                                        child: new DotsIndicator(
                                          controller: _controller,
                                          itemCount: snapshot.data.length,
                                          onPageSelected: (int page) {
                                            _controller.animateToPage(
                                              page,
                                              duration: _kDuration,
                                              curve: _kCurve,
                                            );
                                          },
                                        ),
                                      ),
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
                          stream: _bloc.promotionList,
                        ),
                      )
                    ])),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return SalonCard(snapshot.data.elementAt(index));
                }, childCount: snapshot.data.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
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
      stream: _bloc.salonList,
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
      child: GestureDetector(
        onTap: () {
          onSalonItemTap(widget.item);
        },
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
      ),
    );
  }

  String getTags(List<String> tags) {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeAll(tags.map((tag) => "#" + tag), " ");
    return stringBuffer.toString();
  }

  void onSalonItemTap(SalonItem item) {
    Navigator.push(
        context, new MaterialPageRoute(
        builder: (context) => new SalonDetailPage(item: item,)));
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
      height: 200.0,
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

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 5.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 1.7;

  // The distance between the center of each dot
  static const double _kDotSpacing = 14.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
