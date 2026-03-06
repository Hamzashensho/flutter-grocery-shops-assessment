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
  String _searchQuery = "";
  bool _openOnly = false;

  Future<void> fetchShops() async {
    emit(ShopLoading());
    try {
      _allShops = await getShops(NoParams());
      _applyFilters();
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterOpen(bool value) {
    _openOnly = value;
    _applyFilters();
  }

  void _applyFilters() {
    final filtered = _allShops.where((shop) {
      final matchesSearch = shop.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shop.description.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesOpen = _openOnly ? shop.isOpen : true;

      return matchesSearch && matchesOpen;
    }).toList();

    emit(ShopLoaded(filtered));
  }

  void sortByETA() {
    if (state is ShopLoaded) {
      final currentList = List<Shop>.from((state as ShopLoaded).shops);

      currentList.sort((a, b) {
        // Helper to extract "30" from "30 minutes"
        int getMinutes(String eta) => int.tryParse(eta.split(' ')[0]) ?? 0;
        return getMinutes(a.eta).compareTo(getMinutes(b.eta));
      });

      emit(ShopLoaded(currentList));
    }
  }

  void sortByMinimumOrder() {
    if (state is ShopLoaded) {
      final currentShops = List<Shop>.from((state as ShopLoaded).shops);

      currentShops.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

      emit(ShopLoaded(currentShops));
    }
  }

  void clearFilters() {
    _searchQuery = "";
    _openOnly = false;
    _applyFilters();
  }
}