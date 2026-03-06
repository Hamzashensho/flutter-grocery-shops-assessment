
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
      id: json['_id']?.toString() ?? '',

      name: json['shopName'] != null ? json['shopName']['en'] ?? '' : '',

      description: json['description'] != null ? json['description']['en'] ?? '' : '',

      coverPhoto: json['coverPhoto'] ?? '',

      eta: json['estimatedDeliveryTime'] ?? '',

      minimumOrder: json['minimumOrder'] != null
          ? (json['minimumOrder']['amount'] ?? 0).toDouble()
          : 0.0,

      location: json['address'] != null ? json['address']['city'] ?? '' : '',

      isOpen: json['is_open'] ?? false,
    );
  }
}