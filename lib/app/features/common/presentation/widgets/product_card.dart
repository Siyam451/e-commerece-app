import 'package:ecommerce_project/app/features/categories/models/category_model.dart';
import 'package:ecommerce_project/app/features/product/data/models/product_model.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app_color.dart';
import '../../../../assets_paths.dart';
import 'favourite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel,
  });

  final ProductModel productModel;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsScreen.name,arguments: productModel.id);
      },
      child: SizedBox(
        width: 150,
        child: Card(
          elevation: 3,
          shadowColor: AppColors.themeColor.withAlpha(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.themeColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child:Image.network(productModel.photo,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,) ,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  productModel.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${productModel.currentPrice}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Row(
                      children: const [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 2),
                        Text('4.5'),
                      ],
                    ),

                    FavouriteButton(),
                  ],
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

