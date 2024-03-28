import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      buildWhen: (previous, current) =>
          (current is AddingOrRemovingFromFavorites) ||
          (current is AddedToFavorites &&
              current.productId == productItem.id) ||
          (current is RemovedFromFavorites &&
              current.productId == productItem.id) ||
          (current is AddToFavoritesError &&
              current.productId == productItem.id),
      builder: (context, state) {
        bool isFavorite = false; 
        if (state is AddedToFavorites) {
          isFavorite = state
              .isFavorite; 
        }
        if (state is RemovedFromFavorites) {
          isFavorite = state
              .isFavorite;
        }

        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.grey2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: productItem.imgUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                    child: IconButton(
                      onPressed: () async {
                      
                        bool favoriteStatus =
                            await homeCubit.isProductInFavorites(productItem);

                        if (favoriteStatus) {
                          homeCubit.removeFromFavorites(productItem.id);
                        } else {
                          homeCubit.addToFavorites(productItem.id);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              productItem.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              productItem.category,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Text(
              '\$${productItem.price}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        );
      },
    );
  }
}
