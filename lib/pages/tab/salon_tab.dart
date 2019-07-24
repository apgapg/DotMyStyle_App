import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salon/bloc/provider.dart';
import 'package:salon/bloc/salon_bloc.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/data/model/stylist_model.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/widget/CityWidget.dart';
import 'package:salon/widget/area_widget.dart';
import 'package:salon/widget/book_card.dart';
import 'package:salon/widget/home/category_container.dart';
import 'package:salon/widget/promotion_card.dart';
import 'package:salon/widget/salon_card.dart';
import 'package:salon/widget/stylist_card.dart';
import 'package:salon/widget/view_all_button.dart';

class SalonTab extends StatefulWidget {
  @override
  SalonTabState createState() {
    return new SalonTabState();
  }
}

class SalonTabState extends State<SalonTab> {
  final _bloc = new SalonBloc();

/*  final _controller = new PageController();
  final _feedPagecontroller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;*/

  @override
  Widget build(BuildContext context) {
    return Provider<SalonBloc>(
      bloc: _bloc,
      child: StreamBuilder(
        builder:
            (BuildContext context, AsyncSnapshot<List<SalonItem>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2.5,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.5,
                              foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black87,
                                      Colors.transparent
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )),
                              child: Image.network(
                                "https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/792857/580/386/m1/fpnw/wm0/instagram-.png?1447980780&s=f0f2dc7135c9356224eabe19bc35f597",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 80.0),
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 44,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                  color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText:
                                        "Search any Salon, Service or Expert",
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(fontSize: 13.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 22.0,
                              top: 32.0,
                              child: Text(
                                "DOT",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.blueGrey[700],
                      )
                    ])),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: 108.0,
                      color: Colors.white,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        children: <Widget>[
                          AreaWidget(
                            "Nearby",
                            animate: true,
                          ),
                          CityWidget(
                            "Delhi",
                            imageUrl:
                            "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/New%20Delhi%20cropped.jpg",
                          ),
                          CityWidget(
                            "Gurgaon",
                            imageUrl:
                            "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/rapid-metro-banner.jpg",
                          ),
                          CityWidget(
                            "Noida",
                            imageUrl:
                            "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/noida.jpg",
                          ),
                          CityWidget(
                            "Ghaziabad",
                            imageUrl:
                            "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/gaziabad%203.jpg",
                          ),
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              SliverList(
                delegate: SliverChildListDelegate(
                  [CategoryContainer()],
                ),
              ),

              /*new SliverPadding(
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
                ),*/
              /* new SliverList(
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
                ])),*/
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              new SliverList(
                delegate: new SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, bottom: 6.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Popular Around You",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Colors.blueGrey[900],
                                    fontSize: 14.0),
                              ),
                            ),
                            /*Text(
                                "DISCOVER THE BEST SALONS NEARBY",
                                style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*  new SliverList(
                delegate: new SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 0.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Popular Around You",
                                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.blueGrey[900], fontSize: 12.0),
                              ),
                            ),

                            */ /*Text(
                                "DISCOVER THE BEST SALONS NEARBY",
                                style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                              ),*/ /*
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
              SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3.0,
                      color: Colors.white,
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                            left: 6.0, right: 6.0, top: 4.0, bottom: 12.0),
                        itemBuilder: (context, index) {
                          return SalonCard(snapshot.data.elementAt(index));
                        },
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  )
                /*SliverList(
                    */ /*     delegate: SliverChildListDelegate((context, index) {
                      return SalonCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length),*/ /*
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SalonCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length,),
                  ),*/
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              new SliverList(
                delegate: new SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, bottom: 6.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Hot Deals Around You",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Colors.blueGrey[900],
                                    fontSize: 14.0),
                              ),
                            ),
                            ViewAll(),
                            /*Text(
                                "DISCOVER THE BEST SALONS NEARBY",
                                style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      Container(
                        height: 190.0,
                        color: Colors.white,
                        child: StreamBuilder(
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PromotionItem>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 6.0,
                                    right: 6.0,
                                    bottom: 4.0,
                                    top: 4.0),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    PromotionCard(
                                        snapshot.data.elementAt(index)),
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
                          stream: _bloc.promotionList,
                        ),
                        padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
                      ),
                    ])),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              new SliverList(
                delegate: new SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, bottom: 6.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Dot Experts",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Colors.blueGrey[900],
                                    fontSize: 14.0),
                              ),
                            ),
                            ViewAll(),
                            /*Text(
                                "DISCOVER THE BEST SALONS NEARBY",
                                style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4.0,
                    color: Colors.white,
                    child: StreamBuilder(
                      builder:
                          (context, AsyncSnapshot<List<StylistItem>> data) {
                        if (data.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 4.0, bottom: 12.0),
                            itemBuilder: (context, index) {
                              return StylistCard(data.data.elementAt(index));
                            },
                            itemCount: data.data.length,
                            scrollDirection: Axis.horizontal,
                          );
                        } else
                          return SizedBox(
                            width: 0.0,
                          );
                      },
                      stream: _bloc.stylistController,
                    ),
                  ),
                ),

                /*SliverList(
                    */ /*     delegate: SliverChildListDelegate((context, index) {
                      return SalonCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length),*/ /*
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SalonCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length,),
                  ),*/
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              new SliverList(
                delegate: new SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, bottom: 6.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Dot Book",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Colors.blueGrey[900],
                                    fontSize: 14.0),
                              ),
                            ),
                            ViewAll(),
                            /*Text(
                                "DISCOVER THE BEST SALONS NEARBY",
                                style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, color: Colors.blueGrey[700], fontSize: 12.0),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3.2,
                    color: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                          left: 6.0, right: 6.0, top: 4.0, bottom: 12.0),
                      itemBuilder: (context, index) {
                        return BookCard(snapshot.data.elementAt(index));
                      },
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            ]);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.salonPopularList,
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
        style: TextStyle(
            color: Colors.white.withOpacity(1.0),
            letterSpacing: 1.0,
            fontSize: 9.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
