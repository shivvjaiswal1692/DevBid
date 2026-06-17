import 'package:devbid/screens/payment_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:devbid/widgets/app_input_field.dart';
import 'package:flutter/material.dart';

class OfferBidScreen extends StatefulWidget {
  const OfferBidScreen({super.key});
  static const routeName = '/offer-bid';

  @override
  State<OfferBidScreen> createState() => _OfferBidScreenState();
}

class _OfferBidScreenState extends State<OfferBidScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offer / Bid')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppInputField(
                label: 'Enter your bid',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Bid amount is required';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                text: 'Submit Bid',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, PaymentScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
