
import 'package:flutter/material.dart';

typedef void OnItemClick(String item);

class BottomBarItem extends StatelessWidget {
  final String text;

  final bool selected;

  final IconData rss_feed;

  final OnItemClick onBottomBarItemTap;

  BottomBarItem(this.text, this.selected, this.rss_feed, this.onBottomBarItemTap);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onBottomBarItemTap(text);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                rss_feed,
                size: 20.0,
                color: selected ? Colors.blueAccent : Colors.grey[700],
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0, color: selected ? Colors.blueAccent : Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
