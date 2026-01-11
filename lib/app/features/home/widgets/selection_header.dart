import 'package:ecommerce_project/app/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionHeader extends StatelessWidget {
  const SelectionHeader({super.key, required this.title, required this.onTap,});
 final String title;
 final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextTheme.of(context).titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),),
        TextButton(onPressed:
          onTap,
         child: Text('See All',style: TextStyle(color: AppColors.themeColor),))
      ],
    );
  }
}
