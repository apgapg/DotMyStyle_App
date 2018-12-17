import 'package:flutter/material.dart';
import 'package:salon/bloc/product_list_bloc.dart';
import 'package:salon/data/model/product_list_model.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/widget/product_card.dart';

class ProductListTab extends StatefulWidget {
  ProductListTab();

  _ProductListTabState createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  ProductListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = new ProductListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(4.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ProductCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.productStream,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
