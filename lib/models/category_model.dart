class CategoryModel {
  final String name;
  final String imgUrl;

  CategoryModel({required this.name, required this.imgUrl});
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});

    return result;
  }

  factory CategoryModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return CategoryModel(
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}
  

