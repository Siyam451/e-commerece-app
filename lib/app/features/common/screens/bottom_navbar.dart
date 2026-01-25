
import 'package:ecommerce_project/app/features/common/provider/bottom_navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_color.dart';
import '../../auth/presentation/providers/auth_controller.dart';
import '../../auth/presentation/screens/sign_up_screen.dart';
import '../../cartList/presentation/screens/cart_list_screen.dart';
import '../../categories/presentation/categorieslist_screen.dart';
import '../../categories/provider/category_list_provider.dart';
import '../../home/presentation/home_screen.dart';
import '../../home/providers/home_slider_provider.dart';
import '../../wish-list/presentation/screens/wishList_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  static const String name = '/main-bottom-nav-holder';

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // final List<Widget> _screens = [
  //   HomeScreen(),
  //   CategoriesListScreen(),
  //   CartListScreen(),
  //   WishlistScreen(),
  // ];
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return CategoriesListScreen();
      case 2:
        return CartListScreen();
      case 3:
        return WishlistScreen();
      default:
        return HomeScreen();
    }
  }


  @override
  void initState() {
    super.initState();
    context.read<CategoryListProvider>().fetchCategoryList();
    context.read<HomeSliderProvider>().gethomeSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarProvider>(
      builder: (context, bottomnavbarprovider, _) {
        return Scaffold(
          body: _getScreen(bottomnavbarprovider.selectedIndex),

          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColors.themeColor,
            currentIndex: bottomnavbarprovider.selectedIndex,
            onTap: (int index) async {
              if (index == 2 || index == 3) {
                final isLoggedIn = await AuthController.IsUserAlreadyLoggedIn();
                if (!isLoggedIn) {
                  Navigator.pushNamed(context, SignUpScreen.name);
                  return;
                }
              }

              bottomnavbarprovider.changeItem(index);
            },

            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Carts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_rounded),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}