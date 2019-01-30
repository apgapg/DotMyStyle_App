import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/data/model/stylist_model.dart';
import 'package:salon/pages/stylist_detail_page.dart';
import 'package:salon/pages/tab/salon_tab.dart';

class StylistCard extends StatefulWidget {
  final StylistItem item;

  StylistCard(this.item);

  _StylistCardState createState() => _StylistCardState();
}

class _StylistCardState extends State<StylistCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            onItemTap(widget.item);
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
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.item.profilePicture,
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
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
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


  void onItemTap(StylistItem item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) =>
        new StylistDetailPage(
              item: item,
            ),
      ),
    );
  }
}
