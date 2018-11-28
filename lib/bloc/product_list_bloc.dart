import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/model/product_list_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/utils/log_utils.dart';

class ProductListBloc extends BaseBloc {
  BehaviorSubject<List<ProductItem>> _productSubject;

  ProductListBloc() {
    _productSubject = new BehaviorSubject();
    initData();
  }

  get productStream => _productSubject.stream;

  void initData() async {
    var _res = await apiHelper.getWithAuth(endpoint: ApiEndpoint.productList);
    NetworkResponse _response = apiHelper.parseResponse(_res);
    if (_response.isSuccess) {
      printLog(_response.message);
      ProductListModel _model = ProductListModel.fromJson(json.decode(_response.response.body));
      _productSubject.sink.add(_model.list);
      //SalonDetailModel model =
      //  SalonDetailModel.fromJson(json.decode(response.body));
      // serviceDetail.sink.add(model);
    } else {
      printLog(_response.message);
      _productSubject.sink.addError(_response.message);

    }
  }

  @override
  void dispose() {
    _productSubject.close();
  }
}
