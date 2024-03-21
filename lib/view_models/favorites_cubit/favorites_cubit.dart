import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final favProducts = favoritesProducts;
  List<ProductItemModel> filteredProducts = [];

  void getFavoritesData() {
    emit(FavoritesLoading());
    try {
      emit(FavoritesLoaded(favProducts));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void removeFromFavorites(int index) {
    favProducts.removeAt(index);
    emit(FavoritesLoaded(favProducts));
  }

  void applyFilter(String filterOption) {
    switch (filterOption) {
      case 'All':
        filteredProducts = List.from(favProducts);
        break;
      case 'Top Rated':
        break;
      case 'Latest':
        break;
      case 'Most Popular':
        break;
      case 'Most Expensive':
        break;
    }
    emit(FavoritesLoaded(filteredProducts));
  }
}
