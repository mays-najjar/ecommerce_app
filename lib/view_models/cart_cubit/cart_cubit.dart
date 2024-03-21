
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
         List<ProductItemModel> cartProduct = cartProducts ;
   double? subTotal;

      emit(CartLoaded(
        cartProduct: cartProduct,
        subtotal: subTotal,
      ));
    } catch (e) {
      emit(
        CartError(message: e.toString()),
      );
    }
  }


 

  
}
