import 'package:ecommerce_project/app/features/categories/models/category_model.dart';
import 'package:ecommerce_project/app/features/categories/presentation/categorieslist_screen.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_list_by_categories.dart';
import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../../extensions/localization_extension.dart';
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.categoryModel,
  });
final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(//button korlam aita use kore
      onTap: (){
        Navigator.pushNamed(context, ProductListByCategoryScreen.name,arguments: categoryModel);
      },
      child: Column(
          children: [
            Card(
              elevation: 0,
              color: AppColors.themeColor.withAlpha(30),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.network(categoryModel.icon,width:  28,height:28,color: AppColors.themeColor,
                    errorBuilder: (_,_,_)=>Icon(Icons.error,color: Colors.grey,size: 28,)//j gula te image takbe na eguka te aita show korbe

                ),
              ),
            ),

            Text(categoryModel.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
          ],
        ),
    );

  }
}