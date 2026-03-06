import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/shops/domain/entities/shop.dart';
import 'package:shop/features/shops/domain/repositories/shop_repository.dart';

class GetShops implements UseCase<List<Shop>, NoParams> {
  final ShopRepository repository;

  GetShops(this.repository);

  @override
  Future<List<Shop>> call(NoParams params) async {
    return await repository.getShops();
  }
}