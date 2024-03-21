import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? size;
  int counter = 1;
  final List<ProductItemModel> product = dummyProducts;
  final List<ProductItemModel> cartProduct = cartProducts;

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = dummyProducts[productId];
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> addToCart(String productId) async {
    emit(AddingToCart());
    try {
      emit(AddedToCart());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  void changeSize(ProductSize value) {
    size = value;
    emit(SizeChanged(size!));
  }
}
