import 'package:ecommerce_project/app/app_color.dart';
import 'package:ecommerce_project/app/features/categories/presentation/categorieslist_screen.dart';
import 'package:ecommerce_project/app/features/categories/provider/category_list_provider.dart';
import 'package:ecommerce_project/app/features/home/presentation/home_screen.dart';
import 'package:ecommerce_project/app/features/home/providers/home_slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cartList/presentation/screens/cart_list_screen.dart';
import '../../wish-list/presentation/screens/wishList_screen.dart';
import '../provider/bottom_navbar_provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});
  static const name = '/bottomNavBar';

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  final List<Widget> _screens =[
    HomeScreen(),
    CategoriesListScreen(),
    CartListScreen(),
    WishlistScreen(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryListProvider>().fetchCategoryList();
    context.read<HomeSliderProvider>().gethomeSlider();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarProvider>(
      builder: (context,bottomnavbarprovider,_) {
        return Scaffold(
          body: _screens[bottomnavbarprovider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColors.themeColor,
            currentIndex: bottomnavbarprovider.selectedIndex,
            onTap: bottomnavbarprovider.changeItem,//tap korle chnage item e ja kaj korchi ta show korbe
            showSelectedLabels: true, // jeita select korbo seita special vabe dekhabe
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize),label: 'Catagories'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Shopping craft'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'WishList'),

            ],

          ),
        );
      }
    );
  }
}
