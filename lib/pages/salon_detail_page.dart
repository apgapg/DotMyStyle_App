import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/bloc/salon_detail_bloc.dart';
import 'package:salon/data/model/salon_detail_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/pages/salon_service_page.dart';
import 'package:salon/utils/dialog_utils.dart';

class SalonDetailPage extends StatefulWidget {
  final SalonItem item;

  SalonDetailPage({@required this.item});

  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  SalonDetailBloc _bloc = new SalonDetailBloc();

  @override
  void initState() {
    super.initState();
    _bloc.initData(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: Text(
            widget.item.name,
            style: TextStyle(color: Colors.blueGrey[700]),
          ),
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          elevation: 2.0,
          backgroundColor: Colors.white),
   */
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<SalonDetailModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: CachedNetworkImage(
                        imageUrl: widget.item.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            widget.item.name,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 1.1),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 18.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                widget.item.address,
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Text(
                            "0.2 km",
                            style: TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.green[900],
                            radius: 16.0,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.done_all,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "Currently Open",
                            style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 4.0, bottom: 6.0, left: 10.0, right: 12.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey[200], width: 0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          color: Colors.green),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      color: Colors.blueGrey[50],
                      height: 1.0,
                      margin: EdgeInsets.symmetric(horizontal: 32.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: <Widget>[
                        HeaderWidget("About"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Affinity Salon is a very famous salon chain in whole Delhi NCR Area, is a very famous salon chain in whole Delhi NCR Area.",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                          child: Text(
                            "Timings: ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 2.0),
                          child: Text(
                            "10:00AM - 8:00PM ",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    /*Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: new Wrap(
                        spacing: 8.0,
                        // gap between adjacent chips
                        runSpacing: 8.0, // gap between lines
                        children: getCategories(snapshot.data),
                      ),
                    ),*/
                    SizedBox(
                      height: 6.0,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.salonDetail,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  List<Widget> getCategories(SalonDetailModel salonDetailModel) {
    return salonDetailModel.categories
        .map(
          (categoryItem) => GestureDetector(
        child: Chip(
          label: Text(
            categoryItem.category,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.pinkAccent,
        ),
        onTap: () {
          onCategoryTap(categoryItem, salonDetailModel);
        },
      ),
    )
        .toList();
  }

  void onCategoryTap(CategoryModel categoryModel, SalonDetailModel salonDetailModel) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SalonServicePage(
              categoryModel: categoryModel,
              salonDetailModel: salonDetailModel,
            )));
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: 1.1, fontSize: 16.0),
      ),
    );
  }
}
