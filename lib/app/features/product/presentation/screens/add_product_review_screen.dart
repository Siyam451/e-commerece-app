import 'package:ecommerce_project/app/app_color.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/showsnacbar_masaage.dart';

import 'package:ecommerce_project/app/features/product/providers/product_review_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/bottom_navbar_provider.dart';

class AddProductReviewScreen extends StatefulWidget {
  const AddProductReviewScreen({super.key,   required this.ProductId,});

 final String ProductId;
  static const name = '/AddProductReview';

  @override
  State<AddProductReviewScreen> createState() => _AddProductReviewScreenState();
}

class _AddProductReviewScreenState extends State<AddProductReviewScreen> {
  final _formKey = GlobalKey<FormState>();
   final _firstNameController = TextEditingController();
   final _lastNameController = TextEditingController();
  final _reviewController = TextEditingController();
  int _rating = 4; // default

  CreateProductReviewProvider _createProductReviewProvider = CreateProductReviewProvider();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_,_){
        context.read<BottomNavbarProvider>().BacktoHome();
      },
      child: ChangeNotifierProvider(
        create: (_) => _createProductReviewProvider,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              context.read<BottomNavbarProvider>().BacktoHome();//button diye back er jonno
            }, icon: Icon(Icons.arrow_back)),
            title: Text('Create Review'),
          ),

          body: Consumer<CreateProductReviewProvider>(
            builder: (context,createProductReviewprovider,_) {
              if(createProductReviewprovider.createproductReviewInprogress){
                return CenterCircularProgress();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 8,
                      children: [

                        TextFormField(
                           controller: _firstNameController,
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
                           controller: _lastNameController,
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
                          controller: _reviewController,
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
                            onPressed:
                              _taponsubmitButton,
                             child: Text('Submit',style: TextStyle(color: Colors.white),))


                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }


  void _taponsubmitButton() {
    if (_formKey.currentState!.validate()) {
      _submitButton();
    }
  }

  void _submitButton( )async{

    final isSucess = await _createProductReviewProvider.createProductReview(
        widget.ProductId,
        _reviewController.text.trim(),
        _rating
    );
    if(isSucess){
      ShowSnacbarMassage(context, 'Review added');
      Navigator.pop(context,true);

    }else{
      ShowSnacbarMassage(context, 'something wrong');
    }

  }
}
