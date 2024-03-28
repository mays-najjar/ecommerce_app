import 'package:ecommerce_app/models/announcement_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.getProducts();
      final announcements = await homeServices.getAnnouncements();
      emit(HomeLoaded(products, announcements));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> addToFavorites(String productId) async {
    try {
      final product = await homeServices.getProduct(productId);
      final favProduct = ProductItemModel(
        id: product.id,
        name: product.name,
        imgUrl: product.imgUrl,
        price: product.price,
        category: product.category,
      );
      final currentUser = await authServices.currentUser();
      await homeServices.addToFavorites(currentUser!.uid, favProduct);
     emit(AddedToFavorites(
  productId: product.id,
  isFavorite: true, 
));
    } catch (e) {
      emit(
        AddToFavoritesError(productId, e.toString()),
      );
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    try {
      final product = await homeServices.getProduct(productId);

      final currentUser = await authServices.currentUser();
      await homeServices.removeFromFavorites(currentUser!.uid, product);
      emit(RemovedFromFavorites(
        productId: product.id, isFavorite: false,
      ));
    } catch (e) {
      emit(AddToFavoritesError(productId, e.toString()));
    }
  }

  Future<bool> isProductInFavorites(ProductItemModel productItem) async {
    try {
      final currentUser = await authServices.currentUser();

      final check = await homeServices.checkIfFavoritesDocumentExists(
          currentUser!.uid, productItem);
      return check;
    } catch (e) {
      emit(AddToFavoritesError(productItem.id, e.toString()));
      return false;
    }
  }
}
