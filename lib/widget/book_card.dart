import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/pages/salon_detail_page.dart';
import 'package:salon/pages/tab/salon_tab.dart';

class BookCard extends StatefulWidget {
  final SalonItem item;

  BookCard(this.item);

  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            onSalonItemTap(widget.item);
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            elevation: 1.0,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: widget.item.image,
                          fit: BoxFit.fitHeight,
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
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
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
