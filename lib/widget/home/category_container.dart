import 'package:flutter/material.dart';
import 'package:salon/bloc/provider.dart';
import 'package:salon/bloc/salon_bloc.dart';
import 'package:salon/data/model/category_model.dart';

import 'category_widget.dart';

class CategoryContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SalonBloc>(context);
    return Container(
      height: 136.0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Search by Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: Colors.blueGrey[900],
                        fontSize: 14.0),
                  ),
                ),
                //  ViewAll(),
              ],
            ),
          ),
          StreamBuilder(
              stream: bloc.categoryController,
              builder: (context, AsyncSnapshot<List<CategoryItem>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      children: snapshot.data
                          .map((item) => CategoryWidget(item.category,
                              imageUrl: item.image))
                          .toList(),
                      /*children: <Widget>[
                        CategoryWidget(
                          "Delhi",
                          imageUrl: "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/New%20Delhi%20cropped.jpg",
                        ),
                        CategoryWidget(
                          "Gurgaon",
                          imageUrl: "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/rapid-metro-banner.jpg",
                        ),
                        CategoryWidget(
                          "Noida",
                          imageUrl: "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/noida.jpg",
                        ),
                        CategoryWidget(
                          "Ghaziabad",
                          imageUrl: "https://d53pfl4a028j5.cloudfront.net/uploads/city_image/gaziabad%203.jpg",
                        ),
                      ],*/
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
