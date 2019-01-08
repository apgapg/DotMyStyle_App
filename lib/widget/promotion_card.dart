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
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      margin: EdgeInsets.all(2.0),
      child: Image.network(
        widget.item.promotion_image,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
