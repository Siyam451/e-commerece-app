import 'package:ecommerce_project/app/features/auth/presentation/screens/otp-screen.dart';
import 'package:ecommerce_project/app/features/cartList/presentation/screens/cart_list_screen.dart';
import 'package:ecommerce_project/app/features/cartList/presentation/screens/payment_system_screen.dart';
import 'package:ecommerce_project/app/features/categories/models/category_model.dart';
import 'package:ecommerce_project/app/features/product/data/models/product_review_model.dart';

import 'package:ecommerce_project/app/features/product/presentation/screens/add_product_review_screen.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_details_screen.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_list_by_categories.dart';
import 'package:ecommerce_project/app/features/product/presentation/screens/product_review_screen.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/common/screens/bottom_navbar.dart';


class AppRoutes {
  static Route<dynamic> route(RouteSettings settings) {
    Widget widget = const SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = const SplashScreen();
    } else if (settings.name == SignUpScreen.name) {
      widget = const SignUpScreen();
    } else if (settings.name == SignInScreen.name) {
      widget = const SignInScreen();
    } else if (settings.name == OtpScreen.name) {
      final email = settings.arguments as String;
      widget =  OtpScreen(email: email);
    } else if (settings.name == BottomNavbar.name) {
      widget = const BottomNavbar();
    } else if (settings.name == ProductListByCategoryScreen.name) {
      final categoryModel = settings.arguments as CategoryModel;
      widget = ProductListByCategoryScreen(categoryModel:categoryModel);
    } else if (settings.name == ProductDetailsScreen.name) {
      final productId =settings.arguments as String;
      widget =  ProductDetailsScreen(productId: productId,);
    }else if (settings.name == CartListScreen.name) {
      final count =settings.arguments as int;
      widget = CartListScreen(count: count,);
    }else if (settings.name == ProductReviewScreen.name) {
      final  productId =
      settings.arguments as String;
      widget =  ProductReviewScreen(  productId: productId,);
    }else if (settings.name == AddProductReviewScreen.name) {
      final ProductId =settings.arguments as String;
      widget = AddProductReviewScreen(ProductId: ProductId,);
    } else if (settings.name == PaymentMethodScreen.name) {
      widget = const PaymentMethodScreen();
    }
    return MaterialPageRoute(
        builder: (context) => widget,
        settings: settings,
      );

  }
}
