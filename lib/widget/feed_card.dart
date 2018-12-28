import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon/feed_model.dart';

class FeedCard extends StatefulWidget {
  final FeedItem feedItem;

  FeedCard(this.feedItem);

  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: (widget.feedItem.feed_url),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
                child: RichText(
                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: 'Nunito',
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: widget.feedItem.description + " ",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                          )),
                      new TextSpan(text: getTags(widget.feedItem.tags), style: new TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito', color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "LIKE",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "COMMENT",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )*/
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
