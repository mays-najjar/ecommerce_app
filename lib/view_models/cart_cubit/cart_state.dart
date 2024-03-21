part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}



final class CartLoaded extends CartState {
   List<ProductItemModel> cartProduct = cartProducts ;
  final double? subtotal;

  CartLoaded({
    required this.cartProduct,
    required this.subtotal,
  });
}

final class CartError extends CartState {
  final String message;

  CartError({
    required this.message,
  });
}
