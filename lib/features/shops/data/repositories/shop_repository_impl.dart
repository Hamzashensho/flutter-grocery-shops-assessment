
import 'package:shop/features/shops/data/data_sources/shop_remote_datasource.dart';
import 'package:shop/features/shops/domain/entities/shop.dart';
import 'package:shop/features/shops/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;

  ShopRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Shop>> getShops() async {
    return await remoteDataSource.getShops();
  }
}