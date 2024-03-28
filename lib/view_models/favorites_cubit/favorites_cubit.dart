import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorites_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  List<ProductItemModel> filteredProducts = [];
  final authServices = AuthServicesImpl();
  final favoritesServices = FavoritesServicesImpl();

  void getFavoritesData() async{
    emit(FavoritesLoading());
    try {
     final currentUser = await authServices.currentUser();
      final favoritesProduct = await favoritesServices.getFavoritesItems(currentUser!.uid);
      emit(FavoritesLoaded(
        favProducts: favoritesProduct,
      ));
    } catch (e) {
      emit(
        FavoritesError(message : e.toString())
      );
    }
  }


  Future<void> removeFromFavorites(String productId) async {
    emit(FavoritesLoading());
    try {
    final currentUser = await authServices.currentUser();
    await favoritesServices.removeFromFavorites(currentUser!.uid, productId);

      final favoritesProduct = await favoritesServices.getFavoritesItems(currentUser!.uid);
    
     emit(FavoritesLoaded(
        favProducts: favoritesProduct,
      ));
    } catch (e) {
      emit(
        FavoritesError(message : e.toString())
      );
    }
  }
 
  void applyFilter(String filterOption) async {
    final currentUser = await authServices.currentUser();
      final favoritesProduct = await favoritesServices.getFavoritesItems(currentUser!.uid);
    switch (filterOption) {
      case 'All':
        filteredProducts = List.from(favoritesProduct);
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
    emit(FavoritesLoaded(favProducts: favoritesProduct));
  }
}
