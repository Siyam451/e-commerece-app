import 'package:ecommerce_project/app/features/common/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/bottom_navbar_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_,_){
        context.read<BottomNavbarProvider>().BacktoHome();//screen er back button diye back korte
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            context.read<BottomNavbarProvider>().BacktoHome();//button diye back er jonno
          }, icon: Icon(Icons.arrow_back)),
          title: Text('Wish-list'),
        ),
        body: GridView.builder(
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context,index){
              // return FittedBox(//ai fittedBox ta overflow takle ta auto handle kore
              //     child: ProductCard());
          }

        ),
      ),
    );
  }
}
