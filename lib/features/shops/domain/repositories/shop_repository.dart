
import 'package:shop/features/shops/domain/entities/shop.dart';

abstract class ShopRepository {
  Future<List<Shop>> getShops();
}