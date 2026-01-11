import 'package:ecommerce_project/app/assets_paths.dart';
import 'package:ecommerce_project/app/features/categories/models/category_model.dart';
import 'package:ecommerce_project/app/features/categories/provider/category_list_provider.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/home/providers/home_slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/thememode_provider.dart';
import '../../common/category_card.dart';
import '../../common/presentation/widgets/language_selector.dart';
import '../../common/presentation/widgets/product_card.dart';
import '../../common/provider/bottom_navbar_provider.dart';
import '../../product/presentation/screens/product_details_screen.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/circle_icon_widget.dart';
import '../widgets/selection_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const name = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<CategoryListProvider>().loadInitialCategoryList(); //aita add korle initial vabe ekta load mare
      context.read<HomeSliderProvider>().gethomeSlider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(

            spacing: 8,
            children: [
              Text(AppLocalizations.of(context)!.hello),
              LanguageSelector(),

              SizedBox(height: 20,),

              Consumer<ThememodeProvider>(
                builder: (_, themeProvider, __) {
                  return IconButton(
                    icon: Icon(
                      themeProvider.currentThememode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    onPressed: () {
                      themeProvider.changetheme(
                        themeProvider.currentThememode == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                    },
                  );
                },
              ),

              SearchBar(),
              SizedBox(height: 8,),
              Consumer<HomeSliderProvider>(
                builder: (context,homesliderprovider,_) {
                  if(homesliderprovider.getHomeSliderInprogress){
                    return SizedBox(
                      height: 200,//pura screen e na kore ekta niddisto jaiga porjonto chai tai
                        child: CenterCircularProgress());
                  }
                  return HomeCarouselSlider(sliders:homesliderprovider.homeSliderList,);
                }
              ),

              SizedBox(height: 4,),

              SelectionHeader(title: 'Categories', onTap: () {
                context.read<BottomNavbarProvider>().ChangeToCategories(); // porer screen e jabe
              },),

              _buildCategories(),

              SelectionHeader(title: 'Popular', onTap: (){
              }),

              _buildPopularList(),


              SelectionHeader(title: 'Special', onTap: (){}),

              _buildPopularList(),


              SelectionHeader(title: 'New', onTap: (){}),


              _buildPopularList(),


            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildPopularList() {
    return SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context,index){
                // return ProductCard();
              }),
            );
  }

  Widget _buildCategories() {
    return Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Consumer<CategoryListProvider>(
                    builder: (context,categoryListProvider,_) {
                      if(categoryListProvider.initloading){
                        return CenterCircularProgress();
                      }
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryListProvider.categorylist.length > 10
                              ? 10 : categoryListProvider.categorylist.length, //home screen e category list er shudu 10 ta dekhabe
                          itemBuilder: (context, index) {
                             return CategoryCard(categoryModel: categoryListProvider.categorylist[index],);
                          },
                        separatorBuilder: (context,index)=>SizedBox(width: 5,),
                          );
                    }
                  ),
                ),
              ],
            );
  }

  AppBar buildAppBar() {
    return AppBar(

      title: SvgPicture.asset(AssetPaths.logoNavSvg),
      actions: [


        CircleIconButton(icon: Icons.person, onTap: () {},),
        SizedBox(height: 8,),
        CircleIconButton(icon: Icons.call, onTap: () {},),
        SizedBox(height: 8,),
        CircleIconButton(icon: Icons.notifications_active, onTap: () {},),
        SizedBox(height: 4,),

      ],
    );
  }

}









