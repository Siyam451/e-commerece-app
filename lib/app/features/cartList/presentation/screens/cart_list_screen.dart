import 'package:ecommerce_project/app/features/cartList/presentation/screens/payment_system_screen.dart';
import 'package:ecommerce_project/app/features/cartList/providers/cart_list_delete_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_color.dart';
import '../../../common/presentation/widgets/center_circular_inprogress.dart';

import '../../../common/provider/bottom_navbar_provider.dart';
import '../../providers/cart_list_provider.dart';
import '../../widgets/carditem.dart';
class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key, this.count, });
  static const name = '/CartListScreen';
  final int? count;

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartListProvider>().getcartList(widget.count);
    });
  }


  // CartListProvider _cartListProvider = CartListProvider();
  CartListDeleteProvider _cartListDeleteProvider = CartListDeleteProvider();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<BottomNavbarProvider>().BacktoHome();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Cart List'),
      ),

      body: Consumer<CartListProvider>(
        builder: (context, cartlistprovider, _) {
          if (cartlistprovider.cartlistinprogress) {
            return const CenterCircularProgress();
          }

          return Column(
            children: [
              Expanded(
                child: cartlistprovider.cartItem.isEmpty
                    ? const Center(child: Text('Cart is empty'))
                    : ListView.builder(
                  itemCount: cartlistprovider.cartItem.length,
                  itemBuilder: (context, index) {
                    final item = cartlistprovider.cartItem[index];
                    return CardItem(
                      textTheme: textTheme,
                      cartItem: item, refreshParent: () {  },
                    );
                  },
                ),
              ),

              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(40),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Price', style: textTheme.bodyMedium),
                          Text(
                            '${cartlistprovider.totalPrice} TAKA',
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pushNamed(context, PaymentMethodScreen.name);
                          },
                          child: const Text('CheckOut'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }







}