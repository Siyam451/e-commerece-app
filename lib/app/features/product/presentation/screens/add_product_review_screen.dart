import 'package:ecommerce_project/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/bottom_navbar_provider.dart';

class AddProductReviewScreen extends StatefulWidget {
  const AddProductReviewScreen({super.key});
  static const name = '/AddProductReview';

  @override
  State<AddProductReviewScreen> createState() => _AddProductReviewScreenState();
}

class _AddProductReviewScreenState extends State<AddProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_,_){
        context.read<BottomNavbarProvider>().BacktoHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            context.read<BottomNavbarProvider>().BacktoHome();//button diye back er jonno
          }, icon: Icon(Icons.arrow_back)),
          title: Text('Create Review'),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8,
              children: [

                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your First Name';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Write Review',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Cannot Give emtey review';
                    }
                    return null;
                  },
                ),


                FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.themeColor
                    ),
                    onPressed: (){}, child: Text('Submit',style: TextStyle(color: Colors.white),))


              ],
            ),
          ),
        ),
      ),
    );
  }
}
