import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import 'pin_dots_row.dart';
import 'numeric_keypad.dart';

class PaymentPasswordSheet extends StatefulWidget {
  const PaymentPasswordSheet({Key? key}) : super(key: key);

  @override
  State<PaymentPasswordSheet> createState() => _PaymentPasswordSheetState();
}

class _PaymentPasswordSheetState extends State<PaymentPasswordSheet> {
  String _pin = '';

  void _onNumberTap(String number) {
    if (_pin.length < 6) {
      setState(() {
        _pin += number;
      });
      if (_pin.length == 6) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(AppRoutes.purchaseSuccess);
          }
        });
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  'Payment Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please enter the payment password',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 32),
                PinDotsRow(filledCount: _pin.length),
              ],
            ),
          ),
          const Spacer(),
          NumericKeypad(
            onNumberTap: _onNumberTap,
            onBackspace: _onBackspace,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

