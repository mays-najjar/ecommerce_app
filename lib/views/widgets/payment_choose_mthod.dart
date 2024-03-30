import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/view_models/payment_choose_method_cubit/payment_choose_method_cubit.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/payment_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentChooseMethod extends StatelessWidget {
  const PaymentChooseMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentChooseMethodCubit>(context);

    return BlocBuilder<PaymentChooseMethodCubit, PaymentChooseMethodState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is PaymentChooseMethodLoaded ||
            current is PaymentChooseMethodLoading ||
            current is PaymentChooseMethodError,
        builder: (context, state) {
          if (state is PaymentChooseMethodLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is PaymentChooseMethodError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is PaymentChooseMethodLoaded) {
            final paymentMethod = state.paymentMethods;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentMethod.length,
                    itemBuilder: (context, index) {
                      final paymentMethodItem = paymentMethod[index];
                      return PaymentItemWidget(
                        paymentMethodItem: paymentMethodItem,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.addPaymentMethod,
                      );
                    },
                    child: const Text('Add Payment Method'),
                  ),
                  const Spacer(),
                  MainButton(
                    title: 'Coniform Order',
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.setting,
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error Page!'),
            );
          }
        });
  }
}
