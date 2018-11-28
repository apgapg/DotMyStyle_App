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
      appBar: AppBar(
          title: Text(
            widget.item.name,
            style: TextStyle(color: Colors.blueGrey[700]),
          ),
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          elevation: 2.0,
          backgroundColor: Colors.white),
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
                margin: EdgeInsets.all(4.0),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        child: Image.network(
                          widget.item.image,
                          fit: BoxFit.fitWidth,
                          height: 200.0,
                        ),
                        borderRadius: new BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      HeaderWidget("Address"),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                        child: Text(
                          widget.item.address,
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      HeaderWidget("Services"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: new Wrap(
                          spacing: 8.0,
                          // gap between adjacent chips
                          runSpacing: 8.0, // gap between lines
                          children: getCategories(snapshot.data),
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                    ],
                  ),
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
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey[700],
        ),
      ),
    );
  }
}
