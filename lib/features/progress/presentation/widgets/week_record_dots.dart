import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class WeekRecordDots extends StatelessWidget {
  final int activeDays;

  const WeekRecordDots({
    Key? key,
    this.activeDays = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        7,
        (index) => Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index < activeDays
                ? AppColors.primary
                : AppColors.backgroundLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: index < activeDays
                    ? AppColors.buttonText
                    : AppColors.textSecondary,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

