import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FavoritsPage extends StatefulWidget {
  const FavoritsPage({super.key});

  @override
  State<FavoritsPage> createState() => _FavoritsPageState();
}

class _FavoritsPageState extends State<FavoritsPage> {
  final List<String> filterOptions = [
    'All',
    'Top Rated',
    'Latest',
    'Most Popular',
    'Most Expensive'
  ];
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    debugPrint('FavoritesPage build()');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (String filterOption in filterOptions)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = filterOption;
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return selectedFilter == filterOption
                                ? Theme.of(context).primaryColor
                                : null;
                          },
                        ),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return selectedFilter == filterOption
                                ? AppColors.white
                                : null;
                          },
                        ),
                      ),
                      child: Text(filterOption),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                return buildProductCard(context, index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {},
                child: Image.network(
                  dummyProducts[index].imgUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    dummyProducts.remove(dummyProducts[index]);
                  });
                },
                icon: const Icon(Icons.favorite),
                iconSize: 20.0,
                color: AppColors.red,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            dummyProducts[index].name,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            dummyProducts[index].category,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors.yellow),
            textAlign: TextAlign.center,
          ),
          Text(
            '\$${dummyProducts[index].price}',
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
