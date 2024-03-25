enum ProductSize {
  S,
  M,
  L,
  XL,
  XXL;

  static ProductSize fromString(String size) {
    if (size == ProductSize.S.name) {
      return ProductSize.S;
    } else if (size == ProductSize.M.name) {
      return ProductSize.M;
    } else if (size == ProductSize.L.name) {
      return ProductSize.L;
    } else if (size == ProductSize.XL.name) {
      return ProductSize.XL;
    } else {
      return ProductSize.XXL;
    }
  }
}

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final String description;
  final double price;
  final String category;
  final double averageRate;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    required this.category,
    this.averageRate = 4.5,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    double? price,
    String? category,
    double? averageRate,
    int? quantity,
    ProductSize? size,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'category': category});
    result.addAll({'averageRate': averageRate});

    return result;
  }

  factory ProductItemModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ProductItemModel(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      averageRate: map['averageRate']?.toDouble() ?? 0.0,
    );
  }
}
   List<ProductItemModel> favoritesProducts= [];
