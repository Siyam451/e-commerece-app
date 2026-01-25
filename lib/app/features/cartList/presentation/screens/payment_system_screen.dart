import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/flutter_sslcommerz.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

import '../../../../app_color.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});
  static const name = '/PaymentMethodScreen';

  @override
  State<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'cod';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Payment Method',
                style: textTheme.titleLarge),
            const SizedBox(height: 16),

            _paymentTile(
              value: 'cod',
              title: 'Cash on Delivery',
              subtitle: 'Pay when product arrives',
              icon: Icons.money,
            ),

            _paymentTile(
              value: 'online',
              title: 'Online Payment',
              subtitle: 'Card / bKash / Nagad',
              icon: Icons.credit_card,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onConfirmPayment,
                child: const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onConfirmPayment() {
    if (_selectedMethod == 'cod') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order placed with Cash on Delivery'),
        ),
      );
      Navigator.pop(context);
    } else {
      _startSSLCommerzTransaction();
    }
  }

  Widget _paymentTile({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() => _selectedMethod = value!);
        },
        title: Text(title),
        subtitle: Text(subtitle),
        secondary: Icon(icon, color: AppColors.themeColor),
      ),
    );
  }

  /// ================= SSLCommerz =================

  Future<void> _startSSLCommerzTransaction() async {
    final sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        store_id: "testbox",
        store_passwd: "qwerty",
        total_amount: 500.0,
        currency: SSLCurrencyType.BDT,
        tran_id: DateTime.now().millisecondsSinceEpoch.toString(),
        product_category: "Ecommerce",
        sdkType: SSLCSdkType.TESTBOX,
      ),
    );

    try {
      SSLCTransactionInfoModel result =
      await sslcommerz.payNow();

      _handlePaymentResult(result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }

  void _handlePaymentResult(SSLCTransactionInfoModel result) {
    if (result.status == 'VALID') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Successful')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Payment Failed (Status: ${result.status})',
          ),
        ),

      );
    }
  }
}
