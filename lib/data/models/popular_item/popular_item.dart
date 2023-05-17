import 'dart:convert';

import 'product.dart';

class PopularItem {
  int? totalSize;
  int? typeId;
  int? offset;
  List<Product>? products;

  PopularItem({this.totalSize, this.typeId, this.offset, this.products});

  @override
  String toString() {
    return 'PopularItem(totalSize: $totalSize, typeId: $typeId, offset: $offset, products: $products)';
  }

  factory PopularItem.fromMap(Map<String, Object?> data) => PopularItem(
        totalSize: data['total_size'] as int?,
        typeId: data['type_id'] as int?,
        offset: data['offset'] as int?,
        products: (data['products'] as List<dynamic>?)
            ?.map((e) => Product.fromMap(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toMap() => {
        'total_size': totalSize,
        'type_id': typeId,
        'offset': offset,
        'products': products?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PopularItem].
  factory PopularItem.fromJson(String data) {
    return PopularItem.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [PopularItem] to a JSON string.
  String toJson() => json.encode(toMap());

  PopularItem copyWith({
    int? totalSize,
    int? typeId,
    int? offset,
    List<Product>? products,
  }) {
    return PopularItem(
      totalSize: totalSize ?? this.totalSize,
      typeId: typeId ?? this.typeId,
      offset: offset ?? this.offset,
      products: products ?? this.products,
    );
  }
}
