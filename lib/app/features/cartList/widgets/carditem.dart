import 'package:flutter/material.dart';

import '../../../app_color.dart';
import '../../../assets_paths.dart';
import 'inc_dec_button.dart';
class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(50),
      child: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.logoPNG,height: 70,width: 90,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('New year Nike Shoe',
                                maxLines: 1,
                                style: textTheme.bodyLarge?.copyWith(overflow: TextOverflow.ellipsis)),
                            Text(
                              'Color: Black Size: XL',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                      ),

                      Icon(Icons.delete,color: Colors.grey,),
                    ],

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1000TAKA',style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor)
                      ),


                      IncDecButton(onChange: (int value) {},),



                    ],
                  )


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}