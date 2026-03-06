import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/shops/domain/entities/shop.dart';
import 'package:shop/features/shops/domain/use_cases/get_shop_usecase.dart';

part 'shop_state.dart';
class ShopCubit extends Cubit<ShopState> {
  final GetShops getShops;

  ShopCubit(this.getShops) : super(ShopInitial());

  List<Shop> _allShops = [];
  List<Shop> _filteredShops = [];

  bool openOnly = false;

  Future<void> fetchShops() async {
    emit(ShopLoading());

    try {
      final shops = await getShops(NoParams());

      _allShops = shops;
      _filteredShops = shops;

      emit(ShopLoaded(_filteredShops));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  void search(String query) {
    final results = _allShops.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase()) ||
          shop.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _filteredShops = results;

    emit(ShopLoaded(_filteredShops));
  }

  void filterOpen(bool value) {
    openOnly = value;

    if (openOnly) {
      _filteredShops =
          _allShops.where((shop) => shop.isOpen).toList();
    } else {
      _filteredShops = List.from(_allShops);
    }

    emit(ShopLoaded(_filteredShops));
  }

  void sortByETA() {
    _filteredShops.sort((a, b) => a.eta.compareTo(b.eta));
    emit(ShopLoaded(List.from(_filteredShops)));
  }

  void sortByMinimumOrder() {
    _filteredShops
        .sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    emit(ShopLoaded(List.from(_filteredShops)));
  }

  void clearFilters() {
    _filteredShops = List.from(_allShops);
    openOnly = false;

    emit(ShopLoaded(_filteredShops));
  }
}