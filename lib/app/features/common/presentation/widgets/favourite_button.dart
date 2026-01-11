import 'package:flutter/material.dart';

import '../../../../app_color.dart';
class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: AppColors.themeColor,
      size: 20,
    );
  }
}