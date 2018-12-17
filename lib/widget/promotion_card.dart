import 'package:flutter/material.dart';
import 'package:salon/data/model/promotion_model.dart';

class PromotionCard extends StatefulWidget {
  final PromotionItem item;

  PromotionCard(this.item);

  _PromotionCardState createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          child: Image.network(
            widget.item.promotion_image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
