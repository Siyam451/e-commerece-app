import 'package:ecommerce_project/app/features/auth/presentation/providers/auth_controller.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/sign_up_screen.dart';

import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/showsnacbar_masaage.dart';
import 'package:ecommerce_project/app/features/common/provider/add_to_cart_provider.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_review_screen.dart';
import 'package:ecommerce_project/app/features/product/providers/product_details_provider.dart';
import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_color.dart';
import '../../../cartList/widgets/inc_dec_button.dart';
import '../../../common/presentation/widgets/favourite_button.dart';
import '../../widgets/carousel_image_picker.dart';
import '../../widgets/color_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  static const name = '/ProductDetails';
   final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();
  AddToCartProvider _addToCartProvider = AddToCartProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      _productDetailsProvider.getproductdetails(widget.productId);
    },);
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
        appBar:AppBar(title: Text('Product Details'),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=> _productDetailsProvider),
             ChangeNotifierProvider(create: (_)=> _addToCartProvider),
          ],
          child: Consumer<ProductDetailsProvider>(
            builder: (context,_,_) {
              if(_productDetailsProvider.ProductDetailsInprogress){
                return CenterCircularProgress();
              }
              return Column(
                spacing: 2,
                children: [
                  Expanded(child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselImagePicker(imageUrls: _productDetailsProvider.productdetailmodel?.photos?? [],),

                          SizedBox(height: 8,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_productDetailsProvider.productdetailmodel?.title ?? "",style: textTheme.bodyLarge,),

                              IncDecButton(
                                maxvalue: _productDetailsProvider.productdetailmodel?.quantity ?? 20, // amder joto ta takbe api te toto ta jate nite pari
                                onChange:
                                  (int newvalue) {

                              },),
                            ],
                          ),

                          SizedBox(height: 6,),

                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              SizedBox(width: 2),
                              Text('4.5'),
                              SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, ProductReviewScreen.name);
                                },
                                child: Text(AppLocalizations.of(context)!.reviews),
                              ),
                              FavouriteButton(),
                            ],
                          ),
                          if(_productDetailsProvider.productdetailmodel?.colors.isNotEmpty ?? false)

                          Text('Colors',style: textTheme.bodyLarge,),

                          ColorPicker(colors: _productDetailsProvider.productdetailmodel?.colors ?? [], onChange: (selectedcolor){}),

                          SizedBox(height: 6,),
                          if(_productDetailsProvider.productdetailmodel?.sizes.isNotEmpty ?? false) //jdi size ba colour na thake taile aita show korbe na

                          Text('Sizes',style: textTheme.bodyLarge,),

                          ColorPicker(colors:_productDetailsProvider.productdetailmodel?.sizes ?? [] , onChange: (selectedsize){}),
                          SizedBox(height: 6,),

                          Text('Description',style: textTheme.bodyLarge,),
                          SizedBox(height: 4,),
                          Text(_productDetailsProvider.productdetailmodel?.description ?? ''),







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
                                Text('Price',style: textTheme.bodyMedium,),

                                Text('${_productDetailsProvider.productdetailmodel?.price ?? ''}',style: textTheme.titleMedium?.copyWith(color: AppColors.themeColor)),

                              ],
                            ),





                              SizedBox(
                                width: 120,
                                child: Consumer<AddToCartProvider>(
                                  builder: (context,addtocartprovider,_) {
                                    if(addtocartprovider.addtocartinprogress){
                                      return CenterCircularProgress();
                                    }
                                    return FilledButton(
                                        onPressed: _AddtoCartButton,
                                     child: Text('Add to Cart')
                                    );
                                  }
                                ),
                              )

                        ],
                      ),
                    ),
                  )

                ],
              );
            }
          ),
        ),


    );
  }

  void _AddtoCartButton()async{
    if(await AuthController.IsUserAlreadyLoggedIn()){
      final bool isSucess = await _addToCartProvider.addtocart(widget.productId);
      if(isSucess){
        ShowSnacbarMassage(context, 'added to cart!');
      }else{
        ShowSnacbarMassage(context, _addToCartProvider.errormassage!);
      }
    }else{
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
}
