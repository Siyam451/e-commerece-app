import 'package:ecommerce_project/app/features/product/presentation/screens/add_product_review_screen.dart';
import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_color.dart';
import '../../../common/provider/bottom_navbar_provider.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});
  static const name = '/ProductReview';

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return PopScope(
      onPopInvokedWithResult: (_,_){
        context.read<BottomNavbarProvider>().BacktoHome();
      },
      child: Scaffold(
        appBar:AppBar(
          leading: IconButton(onPressed: (){
            context.read<BottomNavbarProvider>().BacktoHome();//button diye back er jonno
          }, icon: Icon(Icons.arrow_back)),
          title: Text('Review'),
        ),
        body: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 3,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 4,),
                                Text('Anower Hossen Siyam',style: textTheme.titleMedium,),
                              ],
                            ),

                            Text(AppLocalizations.of(context)!.reviewbyuser),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            )),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color:AppColors.themeColor.withAlpha(40),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4))
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reviews(1000)',style: textTheme.titleMedium?.copyWith(color: Colors.white)),

                      ],
                    ),


                    SizedBox(
                        width: 120,
                        child: FloatingActionButton(onPressed: (){
                          Navigator.pushNamed(context, AddProductReviewScreen.name);
                        },child: Icon(Icons.add,color: AppColors.themeColor,),)
                    )
                  ],
                ),
              ),
            )
          ],
        ),

         
      ),
    );
  }
}
