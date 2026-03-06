import 'package:dio/dio.dart';
import 'package:shop/core/dio/dio_helper.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> getShops();
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {

  @override
  Future<List<ShopModel>> getShops() async {
    final response = await DioHelper.getData(
      url: 'shop/test/find/all/shop',
    );

    final List data = response.data;

    return data.map((e) => ShopModel.fromJson(e)).toList();
  }
}