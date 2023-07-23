import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) =>
    List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromMap(x)));

class Sneakers {
  final String id;
  final String name;
  final String title;
  final String category;
  final List<String> image;
  final String oldPrice;
  final List<dynamic> size;
  final String price;
  final String description;
  Sneakers({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.image,
    required this.oldPrice,
    required this.size,
    required this.price,
    required this.description,
  });

  Sneakers copyWith({
    String? id,
    String? name,
    String? title,
    String? category,
    List<String>? image,
    String? oldPrice,
    List<dynamic>? size,
    String? price,
    String? description,
  }) {
    return Sneakers(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      category: category ?? this.category,
      image: image ?? this.image,
      oldPrice: oldPrice ?? this.oldPrice,
      size: size ?? this.size,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'category': category,
      'image': image,
      'oldPrice': oldPrice,
      'size': size,
      'price': price,
      'description': description,
    };
  }

  factory Sneakers.fromMap(Map<String, dynamic> map) {
    return Sneakers(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      image: List<String>.from((map['image'])),
      oldPrice: map['oldPrice'] ?? '',
      size: List<dynamic>.from((map['size'])),
      price: map['price'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sneakers.fromJson(String source) =>
      Sneakers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sneakers(id: $id, name: $name, title: $title, category: $category, image: $image, oldPrice: $oldPrice, size: $size, price: $price, description: $description)';
  }
}
