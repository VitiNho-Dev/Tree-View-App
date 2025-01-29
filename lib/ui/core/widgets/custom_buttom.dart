import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CustomButtom extends StatelessWidget {
  final String title;
  final String iconPath;

  const CustomButtom({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        spacing: 6,
        children: [
          Image.asset(iconPath),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
