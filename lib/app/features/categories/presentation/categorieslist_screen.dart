import 'package:ecommerce_project/app/features/categories/provider/category_list_provider.dart';
import 'package:ecommerce_project/app/features/common/category_card.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/common/provider/bottom_navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key,});
  static const name = '/CategoryList';
  


  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(_loadmoreData);//lazy loading

  }

  void _loadmoreData(){
    if(_scrollController.position.extentBefore<300){ //300 upor e thaka obostai ekta lazy loading hbe
      context.read<CategoryListProvider>().fetchCategoryList();
    }
  }
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
            title: Text('Categories'),
          ),
          body: Consumer<CategoryListProvider>(
            builder: (context,categorylistprovider,_) {
              if(categorylistprovider.initloading){ // shuru tey ekta loading show korbe
                return CenterCircularProgress();
              }
              return Column(
                children: [
                 Expanded(
                   child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      controller: _scrollController,
                        itemCount: categorylistprovider.categorylist.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,), itemBuilder: (context,index){
                          return CategoryCard(categoryModel: categorylistprovider.categorylist[index],);
                      }),
                                   ),
                 ),
              //load korbe more data
              if(categorylistprovider.loadingmoreData)
               CenterCircularProgress()

                ]
              );
            }
          ),
          ),

    );

  }
}
