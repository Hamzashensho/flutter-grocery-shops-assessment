import 'package:get_it/get_it.dart';
import 'package:shop/core/dio/dio_helper.dart';
import 'package:shop/features/shops/data/data_sources/shop_remote_datasource.dart';
import 'package:shop/features/shops/data/repositories/shop_repository_impl.dart';
import 'package:shop/features/shops/domain/repositories/shop_repository.dart';
import 'package:shop/features/shops/domain/use_cases/get_shop_usecase.dart';
import 'package:shop/features/shops/presentation/bloc/shops_cubit/shop_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {
  /// Core
  DioHelper.init();

  /// Data Sources
  sl.registerLazySingleton<ShopRemoteDataSource>(
        () => ShopRemoteDataSourceImpl(),
  );

  /// Repository
  sl.registerLazySingleton<ShopRepository>(
        () => ShopRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(
        () => GetShops(sl()),
  );

  /// Cubit
  sl.registerFactory(
        () => ShopCubit(sl()),
  );
}