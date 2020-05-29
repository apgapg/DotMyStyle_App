import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CityWidget extends StatefulWidget {
  final String text;

  final String imageUrl;

  CityWidget(this.text, {this.imageUrl = ""});

  @override
  CityWidgetState createState() {
    return new CityWidgetState();
  }
}

class CityWidgetState extends State<CityWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    /* controller = AnimationController(duration: const Duration(milliseconds: 90), vsync: this);
    animation = Tween(begin: 56.0, end: 60.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        await Future.delayed(Duration(milliseconds: 1400));
        controller.forward();
      }
    });
    if (widget.animate) controller.forward();*/
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.0,
      alignment: Alignment.center,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 68.0,
            width: 68.0,
            child: Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: 56.0,
                  width: 56.0,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 56.0,
                    width: 56.0,
                    color: Colors.blueGrey[100],
                  ),
                ),
              ),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
