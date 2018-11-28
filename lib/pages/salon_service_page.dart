import 'package:flutter/material.dart';
import 'package:salon/bloc/service_bloc.dart';
import 'package:salon/data/model/salon_detail_model.dart';
import 'package:salon/data/model/service_model.dart';
import 'package:salon/utils/dialog_utils.dart';

class SalonServicePage extends StatefulWidget {
  final SalonDetailModel salonDetailModel;
  final CategoryModel categoryModel;

  SalonServicePage({@required this.salonDetailModel, this.categoryModel});

  _SalonServicePageState createState() => _SalonServicePageState();
}

class _SalonServicePageState extends State<SalonServicePage> {
  ServiceBloc _bloc = new ServiceBloc();

  @override
  void initState() {
    super.initState();
    _bloc.initData(widget.salonDetailModel.id, widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.salonDetailModel.name,
            style: TextStyle(color: Colors.blueGrey[700]),
          ),
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          elevation: 2.0,
          backgroundColor: Colors.white),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<ServiceModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(4.0),
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getList(snapshot.data.list),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.serviceDetail,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  /*List<Widget> getCategories(SalonDetailModel data) {
    return data.categories
        .map((item) => Chip(
              label: Text(
                item.category,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.pinkAccent,
            ))
        .toList();
  }
*/
  List<Widget> getList(List<ServiceItem> serviceList) {
    assert(serviceList.isNotEmpty);
    List<Widget> _widgetList = new List();
    List<String> _categoryList = getCategories(serviceList);

    for (String category in _categoryList) {
      _widgetList.add(CategoryWidget(category: category));
      var _filteredServiceList = getServices(serviceList, category);
      for (ServiceItem _serviceItem in _filteredServiceList) _widgetList.add(ServiceWidget(serviceItem: _serviceItem));
    }

    return _widgetList;
  }

  List<String> getCategories(List<ServiceItem> list) {
    return list
        .map((serviceItem) {
          return serviceItem.categoryItem.category;
        }).toList()
        .toSet()
        .toList();
  }

  List<ServiceItem> getServices(List<ServiceItem> serviceList, String category) {
    return serviceList.where((serviceItem) => serviceItem.categoryItem.category == category).toList();
  }
}

class CategoryWidget extends StatelessWidget {
  final String category;

  CategoryWidget({@required this.category});
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.pinkAccent,
    );
  }
}

class ServiceWidget extends StatelessWidget {
  final ServiceItem serviceItem;

  ServiceWidget({@required this.serviceItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Row(
        children: <Widget>[
          Flexible(flex: 2,child: Text(serviceItem.name,style: TextStyle(fontSize: 16.0),)),
          SizedBox(
            width: 16.0,
          ),
          Flexible(flex:1,child: Text(serviceItem.price.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.0),)),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey[700],
        ),
      ),
    );
  }
}
