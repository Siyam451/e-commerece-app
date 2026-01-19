import 'package:ecommerce_project/app/features/cartList/data/models/cart_list_model.dart';
import 'package:flutter/material.dart';

import '../../../app_color.dart';
import '../../../assets_paths.dart';
import 'inc_dec_button.dart';
class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.textTheme, required this.cartItem,
  });

  final TextTheme textTheme;
  final CartItem cartItem;

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
            child: cartItem.image != null ? Image.network(
              cartItem.image!,
              height: 70,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _imageErrorWidget();
              },
            ) : _imageErrorWidget(),
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
                            Text(cartItem.title,
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
                      Text('${cartItem.price * cartItem.quantity}TAKA',style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor)
                      ),


                      IgnorePointer(
                        child: IncDecButton(
                          initialValue: cartItem.quantity,
                          onChange: (_) {},
                        ),
                      ),




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
  Widget _imageErrorWidget() {
    return Container(
      height: 70,
      width: 90,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

}