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
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 12.0),
                child: RichText(
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
              Image.network(widget.feedItem.feed_url),
              Padding(
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
              )
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
