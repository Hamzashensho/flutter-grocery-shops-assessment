
import 'package:shop/features/shops/domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    required super.description,
    required super.coverPhoto,
    required super.eta,
    required super.minimumOrder,
    required super.location,
    required super.isOpen,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverPhoto: json['cover_photo'] ?? '',
      eta: json['eta'] ?? 0,
      minimumOrder: (json['minimum_order'] ?? 0).toDouble(),
      location: json['location'] ?? '',
      isOpen: json['is_open'] ?? false,
    );
  }
}