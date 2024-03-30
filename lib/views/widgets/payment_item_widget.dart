import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentItemWidget extends StatefulWidget {
  final PaymentMethodModel paymentMethodItem;

  const PaymentItemWidget({
    Key? key,
    required this.paymentMethodItem,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentItemWidgetState createState() => _PaymentItemWidgetState();
}

class _PaymentItemWidgetState extends State<PaymentItemWidget> {
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.paymentMethodItem.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: widget.paymentMethodItem.imgUrl,
          height: 120,
          width: 120,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.paymentMethodItem.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              widget.paymentMethodItem.cvv,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
          ],
        ),
        const Spacer(),
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            if (value != null && value != _isChecked) {
              setState(() {
                _isChecked = value;
              });
              _updateIsFav(_isChecked);
            }
          },
        ),
      ],
    );
  }

  final authServices = AuthServicesImpl();
  Future<void> _updateIsFav(bool newValue) async {
    final currentUser = await authServices.currentUser();
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      final paymentMethodDoc =
          userDoc.collection('paymentMethods').doc(widget.paymentMethodItem.id);

      await paymentMethodDoc.update({'isFav': newValue});

      if (_isChecked) {
        final querySnapshot = await userDoc.collection('paymentMethods').get();
        querySnapshot.docs.forEach((doc) async {
          if (doc.id != widget.paymentMethodItem.id) {
            await doc.reference.update({'isFav': false});
          }
        });
        setState(() {
          _isChecked = newValue;
        });
      }
    } catch (e) {
      print('Failed to update payment method: $e');
    }
  }
}
