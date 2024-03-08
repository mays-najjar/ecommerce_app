import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesTabView extends StatelessWidget {
   CategoriesTabView({super.key});

  final List<Map<String, String>> categories = [
    {
      'name': 'Shoes',
      'image':
          'https://i.pinimg.com/736x/56/1d/c6/561dc61b6fc231032fe68d4b0302745c.jpg'
    },
    {
      'name': 'Electronics',
      'image':
          'https://i.pinimg.com/564x/05/b4/81/05b481cb6b59f8ee52b535c3f84bc638.jpg'
    },
    {
      'name': 'Bags',
      'image':
          'https://i.pinimg.com/564x/cc/48/a9/cc48a95cff117225b1b238528fffff65.jpg'
    },
    {
      'name': 'Clothes',
      'image':
          'https://threadcurve.com/wp-content/uploads/2020/06/sweater-may142021.jpg'
    },
  ];

  Widget buildCategoryCard(String categoryName, String imageUrl) {
    return Card(
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 8,
            right:
                8, 
            child: Text(
              categoryName,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryName = categories[index]['name']!;
        final imageUrl = categories[index]['image']!;
        return buildCategoryCard(categoryName, imageUrl);
      },
    );
  }
}
