import 'package:ecommerce_app/models/cart_orders_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? size;
  int counter = 0;
  final List<ProductItemModel> product = dummyProducts;
  final List<ProductItemModel> cartProduct = cartProducts;

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product =
          dummyProducts.firstWhere((product) => product.id == productId);
      await Future.delayed(const Duration(seconds: 2));

      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> changeQuantity(int value) async {}
  Future<void> changeSize(ProductSize value) async {
    size = value;
    emit(SizeChanged(size!));
  }

  Future<void> addToCart(String productId) async {
    emit(AddingToCart());
    try {
      final product =
          dummyProducts.firstWhere((product) => product.id == productId);
      DateTime now = DateTime.now();
      final cartOrder = CartOrdersModel(
          id: now.toIso8601String(),
          product: product,
          quantity: counter,
          size: size!,
          totalPrice: counter * product.price);
      dummyCartOrders.add(cartOrder);
      await Future.delayed(const Duration(seconds: 1));
      emit(AddedToCart());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  void incrementCounter() {
    counter++;
    emit(QuantityChanged(counter));
  }

  void decrementCounter() {
    if (counter > 1) {
      counter--;
    }
  }
}
