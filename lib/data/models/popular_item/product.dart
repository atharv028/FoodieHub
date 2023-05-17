import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class Product {
  @primaryKey
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, stars: $stars, img: $img, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, typeId: $typeId)';
  }

  factory Product.fromMap(Map<String, Object?> data) => Product(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        price: data['price'] as int?,
        stars: data['stars'] as int?,
        img: data['img'] as String?,
        location: data['location'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        typeId: data['type_id'] as int?,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'stars': stars,
        'img': img,
        'location': location,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'type_id': typeId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());

  Product copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? stars,
    String? img,
    String? location,
    String? createdAt,
    String? updatedAt,
    int? typeId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stars: stars ?? this.stars,
      img: img ?? this.img,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      typeId: typeId ?? this.typeId,
    );
  }
}
