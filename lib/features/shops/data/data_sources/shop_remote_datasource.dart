import 'package:dio/dio.dart';
import 'package:shop/core/dio/dio_helper.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> getShops();
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {

  ShopRemoteDataSourceImpl();

  @override
  Future<List<ShopModel>> getShops() async {
    final response = await DioHelper.getData(url: 'https://api.orianosy.com/shop/test/find/all/shop', query: {
    'deviceKind': 'mobile',
    },);

    final List data = response.data['result'];

    return data.map((e) => ShopModel.fromJson(e)).toList();
  }
}