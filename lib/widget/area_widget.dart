import 'package:flutter/material.dart';

class AreaWidget extends StatefulWidget {
  final String text;

  final bool animate;

  AreaWidget(this.text, {this.animate = false});

  @override
  AreaWidgetState createState() {
    return new AreaWidgetState();
  }
}

class AreaWidgetState extends State<AreaWidget> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 90), vsync: this);
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
    if (widget.animate) controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.0,
      alignment: Alignment.center,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 68.0,
            width: 68.0,
            child: Container(
              height: animation.value,
              width: animation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.animate ? Colors.redAccent : Colors.blueGrey[100],
              ),
              child: widget.animate
                  ? Center(
                      child: Icon(
                        Icons.my_location,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    )
                  : Center(),
            ),
            alignment: Alignment.center,
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
