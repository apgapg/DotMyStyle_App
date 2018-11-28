import 'package:flutter/material.dart';
import 'package:salon/bloc/product_list_bloc.dart';
import 'package:salon/customWidget/product_card.dart';
import 'package:salon/data/model/product_list_model.dart';
import 'package:salon/utils/dialog_utils.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage();

  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListBloc _bloc = new ProductListBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "DOT Products",
            style: TextStyle(color: Colors.blueGrey[700]),
          ),
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          elevation: 2.0,
          backgroundColor: Colors.white),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
      ),*/
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
