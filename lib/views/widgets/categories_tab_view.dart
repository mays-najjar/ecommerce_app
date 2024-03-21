import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

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
            right: 8,
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
    final cubit = BlocProvider.of<CategoriesCubit>(context);

    return BlocBuilder<CategoriesCubit, CategoriesState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is CategoriesLoading ||
            current is CategoriesLoaded ||
            current is CategoriesError,
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CategoriesError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CategoriesLoaded) {
            final categories = state.categories;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final categoryName = categories[index].name;
                final imageUrl = categories[index].imgUrl;
                return buildCategoryCard(categoryName, imageUrl);
              },
            );
          } else {
            return const SizedBox(height: 100);
          }
        });
  }
}
