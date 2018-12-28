import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/bloc/salon_bloc.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/pages/salon_detail_page.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/widget/feed_card.dart';
import 'package:salon/widget/promotion_card.dart';

class SalonTab extends StatefulWidget {
  @override
  SalonTabState createState() {
    return new SalonTabState();
  }
}

class SalonTabState extends State<SalonTab> {
  SalonBloc _bloc = new SalonBloc();
  final _controller = new PageController();
  final _feedPagecontroller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<SalonItem>> snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[

              new SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                  Container(
                    height: 200.0,
                    child: StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot<List<PromotionItem>> snapshot) {
                        if (snapshot.hasData) {
                          return Stack(
                            children: <Widget>[
                              PageView.builder(
                                controller: _controller,
                                itemBuilder: (context, index) => PromotionCard(snapshot.data.elementAt(index)),
                                itemCount: snapshot.data.length,
                              ),
                              new Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: new Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black38], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                    padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
                    color: Colors.blueGrey[50],
                  ),
                ])),
              ),


              new SliverList(
                  delegate: new SliverChildListDelegate([
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "NEAR SALONS",
                              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "DISCOVER THE BEST SALONS NEARBY",
                              style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),

              SliverPadding(
                padding: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return SalonCard(snapshot.data.elementAt(index));
                  }, childCount: snapshot.data.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.1),
                ),
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate([
                    Container(
                      color: Colors.blueGrey[50],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "DOT BOOK",
                              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "READ WHAT'S THE LATEST IN",
                              style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200.0,
                      padding: EdgeInsets.only(bottom: 8.0),
                      color: Colors.blueGrey[50],
                      child: StreamBuilder(
                        builder: (BuildContext context, AsyncSnapshot<List<FeedItem>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, index) {
                                return FeedCard(snapshot.data.elementAt(index));
                              },
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Some error..."),
                            );
                          } else {
                            return DialogUtils.showCircularProgressBar();
                          }
                        },
                        stream: _bloc.feedController,
                      ),
                    )
                  ])),

              new SliverList(
                  delegate: new SliverChildListDelegate([
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "MORE SALONS",
                              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "LISTING OTHER QUALITY SALONS",
                              style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),

              StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot<List<SalonItem>> snapshot) {
                  if (snapshot.hasData) {
                    return SliverPadding(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return SalonCard(snapshot.data.elementAt(index));
                        }, childCount: snapshot.data.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.1),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: Text("Some error..."),
                        ),
                      ]),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: DialogUtils.showCircularProgressBar(),
                        ),
                      ]),
                    );
                  }
                },
                stream: _bloc.salonExtraList,
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
      stream: _bloc.salonPopularList,
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
          margin: EdgeInsets.all(4.0),
          elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
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
                        ],
                      ),
                    ),

                    //  Image.network(widget.item.Salon_u),
                  ],
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: GenderWidget(widget.item.genderType),
                ),
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
        context,
        new MaterialPageRoute(
            builder: (context) => new SalonDetailPage(
                  item: item,
                )));
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.highlightColor: Colors.white,
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
  final Color highlightColor;
  final Color color = Colors.white.withOpacity(0.7);

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
          color: index == controller.page ? highlightColor : color,
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

class GenderWidget extends StatelessWidget {
  final String genderType;

  GenderWidget(this.genderType);

  @override
  Widget build(BuildContext context) {
    assert(genderType != null && genderType.isNotEmpty);
    return Container(
      height: 20.0,
      padding: EdgeInsets.only(left: 6.0, right: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
        color: Colors.black.withOpacity(0.75),
      ),
      child: Text(
        genderType.replaceAll(r'-d', "").toUpperCase(),
        style: TextStyle(color: Colors.white.withOpacity(1.0), letterSpacing: 1.0, fontSize: 9.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
