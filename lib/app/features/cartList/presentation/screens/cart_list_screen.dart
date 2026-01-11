import 'package:ecommerce_project/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/bottom_navbar_provider.dart';
import '../../widgets/carditem.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  static const name = '/CartListScreen';

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<BottomNavbarProvider>().BacktoHome();//button diye back er jonno
        }, icon: Icon(Icons.arrow_back)),
        title: Text('Cart-list'),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
                  return CardItem(textTheme: textTheme);
                }),
          ),

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
                      Text('Total Price',style: textTheme.bodyMedium,),

                      Text('100000 TAKA',style: textTheme.titleMedium?.copyWith(color: AppColors.themeColor)),

                    ],
                  ),


                  SizedBox(
                      width: 120,
                      child: FilledButton(onPressed: (){}, child: Text('CheckOut')))

                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}


