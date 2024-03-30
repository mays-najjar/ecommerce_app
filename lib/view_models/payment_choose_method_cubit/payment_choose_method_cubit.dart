import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/payment_choose_method_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_choose_method_state.dart';

class PaymentChooseMethodCubit extends Cubit<PaymentChooseMethodState> {
  PaymentChooseMethodCubit() : super(PaymentChooseMethodInitial());
  final authServices = AuthServicesImpl();
  final paymentChooseServices = PaymentChooseServicesImpl();
  Future<void> getPaymentMethod() async {
    emit(PaymentChooseMethodLoading());
    try {
      final currentUser = await authServices.currentUser();

     
      final paymentMethod = (await paymentChooseServices.getPaymentMethods(
        currentUser!.uid,
      ));
      emit(
        PaymentChooseMethodLoaded(
          paymentMethods: paymentMethod,

        ),
      );
    } catch (e) {
      emit(PaymentChooseMethodError(e.toString()));
    }
  }
}
