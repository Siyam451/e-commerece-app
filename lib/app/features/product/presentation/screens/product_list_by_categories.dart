
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../categories/models/category_model.dart';
import '../../../common/presentation/widgets/center_circular_inprogress.dart';
import '../../../common/presentation/widgets/product_card.dart';
import '../../providers/product_list_by_category_provider.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryModel});

  static const String name = '/product-list-by-category';

  final CategoryModel categoryModel;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  late final ProductListByCategoryProvider _productListByCategoryProvider =
  ProductListByCategoryProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListByCategoryProvider.loadInitialProductListbyCategory(
        widget.categoryModel.id,
      );
      _scrollController.addListener(_loadMoreData);
    });
  }

  void _loadMoreData() {
    if (_productListByCategoryProvider.loadingMoreData) {
      return;
    }
    if (_scrollController.position.extentAfter < 300) {
      _productListByCategoryProvider.fetchproductList(widget.categoryModel.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryModel.title)),
      body: ChangeNotifierProvider(
        create: (_) => _productListByCategoryProvider,
        child: Consumer<ProductListByCategoryProvider>(
          builder: (context, productListByCategoryProvider, _) {
            if (productListByCategoryProvider.initialLoading) {
              return CenterCircularProgress();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                controller: _scrollController,
                itemCount: productListByCategoryProvider.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product =
                  productListByCategoryProvider.productList[index];
                  return FittedBox(child: ProductCard(productModel: product));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

