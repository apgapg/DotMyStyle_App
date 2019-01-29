import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/pages/salon_detail_page.dart';
import 'package:salon/pages/tab/salon_tab.dart';

class SalonCard extends StatefulWidget {
  final SalonItem item;

  SalonCard(this.item);

  _SalonCardState createState() => _SalonCardState();
}

class _SalonCardState extends State<SalonCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            onSalonItemTap(widget.item);
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            elevation: 0.0,
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
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(2.0),
                            bottomRight: Radius.circular(2.0),
                            bottomLeft: Radius.circular(2.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.item.name,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0, color: Colors.black),
                              maxLines: 1,
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
            ),
      ),
    );
  }
}
