class CategoryModel {
  final String name;
  final String imgUrl;

  CategoryModel({required this.name, required this.imgUrl});
}

final List<CategoryModel> dummyCategories = [
  CategoryModel(
    name: 'Shoes',
    imgUrl:
        'https://i.pinimg.com/736x/56/1d/c6/561dc61b6fc231032fe68d4b0302745c.jpg',
  ),
  CategoryModel(
    name: 'Electronics',
    imgUrl:
        'https://i.pinimg.com/564x/05/b4/81/05b481cb6b59f8ee52b535c3f84bc638.jpg',
  ),
  CategoryModel(
    name: 'Bags',
    imgUrl:
        'https://i.pinimg.com/564x/cc/48/a9/cc48a95cff117225b1b238528fffff65.jpg',
  ),
  CategoryModel(
    name: 'Clothes',
    imgUrl:
        'https://threadcurve.com/wp-content/uploads/2020/06/sweater-may142021.jpg',
  ),
];
