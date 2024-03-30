import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class PaymentChooseServices {
  Future<List<PaymentMethodModel>> getPaymentMethods(String uid);
  Future<void> updatePreferredPaymentMethod(String uid, bool isFav);
  Future<void> addPaymentMethod(String uid, PaymentMethodModel payment);
}

class PaymentChooseServicesImpl implements PaymentChooseServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods(
    String uid,
  ) async =>
      await firestoreService.getCollection<PaymentMethodModel>(
        path: ApiPaths.paymentMethods(uid),
        builder: (data, documentId) => PaymentMethodModel.fromMap(data),
      );
  @override
  Future<void> updatePreferredPaymentMethod(String uid, bool isFav) async {
    final paymentMethodData = {
      'isFav': isFav,
    };
    await firestoreService.setData(
      path: ApiPaths.paymentMethods(uid),
      data: paymentMethodData,
    );
  }

  @override
  Future<void> addPaymentMethod(String uid, PaymentMethodModel payment) async {
    await firestoreService.setData(
        path: ApiPaths.paymentMethods(uid), data: payment.toMap());
  }
}
