import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';

class AddPaymentMethodPage extends StatelessWidget {
  final authServices = AuthServicesImpl();
  final TextEditingController _namePaymentWayController =
      TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  AddPaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name of payment',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _namePaymentWayController,
                decoration: const InputDecoration(
                  hintText: 'Enter',
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Card Number',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  hintText: 'Enter Card Number',
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Card Holder Name',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Holder Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Expired',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  hintText: 'MM/YY',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'CVV Code',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  hintText: 'CCV',
                  prefixIcon:  Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 32),
              MainButton(
                title: 'Add Card',
                onPressed: () {
                  _addPaymentMethod(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addPaymentMethod(
      String userId, PaymentMethodModel newWay) async {
    try {
      final userCollectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('paymentMethods');

      await userCollectionRef.add({});

      
    } catch (e) {
    
      throw e;
      
    }
  }

  Future<void> _addPaymentMethod(BuildContext context) async {
    final name = _namePaymentWayController.text;
    final cardNumber = _cardNumberController.text;
    final cardHolderName = _cardHolderNameController.text;
    final expiryDate = _expiryDateController.text;
    final cvv = _cvvController.text;

    if (cardNumber.isEmpty ||
        cardHolderName.isEmpty ||
        expiryDate.isEmpty ||
        cvv.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all fields.'),
      ));
      return;
    }
    final PaymentMethodModel newCard = PaymentMethodModel(
       id: DateTime.now().toIso8601String(),
        name: name,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
        cardHolderName: cardHolderName,
        isFav: true);
    final currentUser = await authServices.currentUser();

    try {
      final userCollectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('paymentMethods');

      await userCollectionRef.add(newCard.toMap());
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Card added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to add card: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
