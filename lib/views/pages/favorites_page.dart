import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritsPage extends StatelessWidget {
  FavoritsPage({super.key});
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
    return BlocProvider(
      create: (context) {
        final cubitF = FavoritesCubit();
        cubitF.getFavoritesData();
        return cubitF;
      },
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        buildWhen: (previous, current) =>
            current is FavoritesLoaded ||
            current is FavoritesLoading ||
            current is FavoritesError,
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritesLoaded) {
            return buildFavoritesPage(context, state.favProducts);
          } else if (state is FavoritesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget buildFavoritesPage(
      BuildContext context, List<ProductItemModel> favProducts) {
    final cubitF = BlocProvider.of<FavoritesCubit>(context);

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
                        cubitF.applyFilter(filterOption);
                        selectedFilter = filterOption;
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
              itemCount: favProducts.length,
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
    final cubit = BlocProvider.of<FavoritesCubit>(context);
    final favProducts = cubit.state is FavoritesLoaded
        ? (cubit.state as FavoritesLoaded).favProducts
        : [];

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
                  favProducts[index].imgUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.removeFromFavorites(index);
                },
                icon: const Icon(Icons.favorite),
                iconSize: 20.0,
                color: AppColors.red,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            favProducts[index].name,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            favProducts[index].category,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors.yellow),
            textAlign: TextAlign.center,
          ),
          Text(
            '\$${favProducts[index].price}',
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
