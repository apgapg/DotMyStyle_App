import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/bloc/stylist_detail_bloc.dart';
import 'package:salon/data/model/salon_detail_model.dart';
import 'package:salon/data/model/stylist_detail_model.dart';
import 'package:salon/data/model/stylist_model.dart';
import 'package:salon/pages/salon_service_page.dart';
import 'package:salon/utils/dialog_utils.dart';

class StylistDetailPage extends StatefulWidget {
  final StylistItem item;

  StylistDetailPage({@required this.item});

  _StylistDetailPageState createState() => _StylistDetailPageState();
}

class _StylistDetailPageState extends State<StylistDetailPage> {
  final _bloc = StylistDetailBloc();

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
        builder: (BuildContext context, AsyncSnapshot<StylistDetailModel> snapshot) {
          if (snapshot.hasData) {
            var item = snapshot.data;
            return Container(
              padding: EdgeInsets.only(bottom: 12.0),
              color: Colors.white,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: CachedNetworkImage(
                                imageUrl: widget.item.profilePicture,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SpaceWidget(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                              child: Text(
                                widget.item.name,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 1.1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                widget.item.tagline,
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.phone, size: 15.0, color: Colors.grey[600]),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1.0),
                                    child: Text(
                                      widget.item.phone,
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DividerWidget(),
                            HeaderWidget("About"),
                            SpaceWidget(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                "Affinity Salon is a very famous salon chain in whole Delhi NCR Area, is a very famous salon chain in whole Delhi NCR Area.",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                            DividerWidget(),
                            HeaderWidget("Experience: " + snapshot.data.experience.yearExperience.toString() + " years"),
                            SpaceWidget(),
                            ExperienceList(item.experience.workProfile),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    DividerWidget(),
                    HeaderWidget("Services Offered"),
                    SpaceWidget(),
                    SpaceWidget(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.offeredServices.map((item) => CategoryList(item)).toList(growable: false),
                    )
                  ]))
                ],
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
        stream: _bloc.stylistDetail,
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
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: 1.1, fontSize: 16.0),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Colors.blueGrey[50],
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 32.0),
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}

class SpaceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
    );
  }
}

class ExperienceList extends StatelessWidget {
  final List<WorkProfile> workProfile;

  ExperienceList(this.workProfile);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        children: workProfile.map((item) => ExperienceCard(item)).toList(growable: false),
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final WorkProfile item;

  ExperienceCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // Expanded(
            //   child: Container(color: Colors.grey[300]),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            //  Image.network(widget.item.Salon_u),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final OfferedServices item;

  CategoryList(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey[50], width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
                color: Colors.blueGrey[50].withOpacity(0.5)),
            child: Text(
              item.category,
              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: 1.1, fontSize: 14.0),
            ),
          ),
        ),
        SpaceWidget(),
        Container(
          height: 120.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            children: item.services.map((item) => ServiceCard(item)).toList(growable: false),
          ),
        ),
        SpaceWidget(),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Services item;

  ServiceCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey[50],
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Product:",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
                    maxLines: 1,
                  ),
                  SpaceWidget(),
                  Flexible(
                    child: Text(
                      item.productBrand,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Icon(
                      Icons.access_time,
                      size: 15.0,
                      color: Colors.black87,
                    ),
                  ),
                  SpaceWidget(),
                  Text(
                    item.averageTime,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                    maxLines: 1,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 2.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      "₹",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    item.pricing.basePrice.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "-" + item.pricing.discount.toString() + "%",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.red),
                    maxLines: 1,
                  ),
                ],
              ),
              Text(
                "₹" + item.pricing.salePrice.toString(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
