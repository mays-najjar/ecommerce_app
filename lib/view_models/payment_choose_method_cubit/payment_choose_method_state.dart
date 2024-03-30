part of 'payment_choose_method_cubit.dart';

sealed class PaymentChooseMethodState {}

final class PaymentChooseMethodInitial extends PaymentChooseMethodState {}

final class PaymentChooseMethodLoading extends PaymentChooseMethodState {}

final class PaymentChooseMethodError extends PaymentChooseMethodState {
  final String message;

  PaymentChooseMethodError(this.message);
}

final class PaymentChooseMethodLoaded extends PaymentChooseMethodState {
  final List<PaymentMethodModel> paymentMethods;

  PaymentChooseMethodLoaded({
    required this.paymentMethods,
  });
}
