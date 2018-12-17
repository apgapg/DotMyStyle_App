import 'package:flutter/material.dart';
import 'package:salon/data/model/product_list_model.dart';

class ProductCard extends StatefulWidget {
  final ProductItem item;

  ProductCard(this.item);

  @override
  ProductCardState createState() {
    return new ProductCardState();
  }
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          //  onSalonItemTap(widget.item);
        },
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Image.network(
                  widget.item.image,
                  fit: BoxFit.fitHeight,
                )),
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
                        style: TextStyle(fontWeight: FontWeight.w600),
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
          ),
        ),
      ),
    );
  }
}
