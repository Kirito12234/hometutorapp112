import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class HeaderGreeting extends StatelessWidget {
  const HeaderGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, Shreedhar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonText,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Let\'s start learning',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.buttonText,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.buttonText,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.primary,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

