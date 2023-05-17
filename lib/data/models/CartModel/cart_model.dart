import 'dart:convert';

import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:floor/floor.dart';

enum ProductType { popular, recommended }

@entity
class Cart {
  @PrimaryKey(autoGenerate: false)
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  Product? product;

  Cart({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  @override
  String toString() {
    return 'Cart(id: $id, name: $name, price: $price, img: $img, quantity: $quantity, isExist: $isExist, product: $product)';
  }

  factory Cart.fromMap(Map<String, Object?> data) => Cart(
        id: data['id'] as int?,
        name: data['name'] as String?,
        price: data['price'] as int?,
        img: data['img'] as String?,
        quantity: data['quantity'] as int?,
        isExist: data['isExist'] as bool?,
        time: data['time'] as String?,
        product: data['product'] == null
            ? null
            : Product.fromMap(data['product']! as Map<String, Object?>),
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'img': img,
        'quantity': quantity,
        'isExist': isExist,
        'time': time,
        'product': product?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Cart].
  factory Cart.fromJson(String data) {
    return Cart.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [Cart] to a JSON string.
  String toJson() => json.encode(toMap());
}
