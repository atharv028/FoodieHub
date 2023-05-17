import 'dart:convert';

import 'package:floor/floor.dart';

import '../CartModel/cart_model.dart';

@entity
class History {
  @PrimaryKey(autoGenerate: false)
  String? time;
  List<Cart>? cart;

  History({this.time, this.cart});

  @override
  String toString() => 'History(time: $time, cart: $cart)';

  factory History.fromMap(Map<String, Object?> data) => History(
        time: data['time'] as String?,
        cart: (data['cart'] as List<dynamic>?)
            ?.map((e) => Cart.fromMap(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toMap() => {
        'time': time,
        'cart': cart?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [History].
  factory History.fromJson(String data) {
    return History.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [History] to a JSON string.
  String toJson() => json.encode(toMap());
}
