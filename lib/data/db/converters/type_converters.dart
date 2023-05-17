import 'dart:convert';

import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:floor/floor.dart';

class ProductConverter extends TypeConverter<Product?, String?> {
  @override
  Product? decode(String? databaseValue) {
    return Product.fromJson(databaseValue ?? "");
  }

  @override
  String? encode(Product? value) {
    return value?.toJson();
  }
}

class DateTimeConverter extends TypeConverter<DateTime?, String?> {
  @override
  DateTime? decode(String? databaseValue) {
    // TODO: implement decode
    return DateTime.tryParse(databaseValue ?? "");
    throw UnimplementedError();
  }

  @override
  String? encode(DateTime? value) {
    // TODO: implement encode
    return value.toString();
    throw UnimplementedError();
  }
}

class CartConverter extends TypeConverter<List<Cart>?, String?> {
  @override
  List<Cart>? decode(String? databaseValue) {
    var temp = json.decode(databaseValue!) as Map<String, Object?>;
    return (temp['cart'] as List<dynamic>?)
        ?.map((e) => Cart.fromJson(e))
        .toList();
  }

  @override
  String? encode(List<Cart>? value) {
    Map<String, List<Cart>> ans = Map();
    ans.putIfAbsent('cart', () => value!);
    return json.encode(ans);
  }
}
