import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_color.dart';
import '../../../common/presentation/widgets/center_circular_inprogress.dart';
import '../../../common/provider/bottom_navbar_provider.dart';
import '../../data/models/product_review_model.dart';
import '../../providers/product_review_provider.dart';
import 'add_product_review_screen.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({
    super.key,
    required this.productId,
  });

  final String productId;
  static const name = '/ProductReview';

  @override
  State<ProductReviewScreen> createState() =>
      _ProductReviewScreenState();
}

class _ProductReviewScreenState
    extends State<ProductReviewScreen> {
  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider =
    context.read<ProductReviewProvider>();

    if (provider.loadingMoreData) return;

    if (_scrollController.position.extentAfter < 300) {
      provider.fetchProductReviews(widget.productId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      onPopInvokedWithResult: (_, __) {
        context.read<BottomNavbarProvider>().BacktoHome();
      },
      child: ChangeNotifierProvider(
        create: (_) => ProductReviewProvider()
          ..loadInitialProductReviews(widget.productId),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context
                    .read<BottomNavbarProvider>()
                    .BacktoHome();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Reviews'),
          ),
          body: Consumer<ProductReviewProvider>(
            builder: (context, provider, _) {
              if (provider.initialLoading) {
                return const CenterCircularProgress();
              }

              if (provider.reviewList.isEmpty) {
                return const Center(
                  child: Text('No reviews yet'),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: provider.reviewList.length +
                          (provider.loadingMoreData ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index ==
                            provider.reviewList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: CenterCircularProgress(),
                          );
                        }

                        final review =
                        provider.reviewList[index];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${review.user.firstName} ${review.user.lastName}',
                                      style: textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(review.comment),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// Bottom Bar
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                      AppColors.themeColor.withAlpha(40),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews (${provider.reviewList.length})',
                          style: textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            final newReview =
                            await Navigator.pushNamed(
                              context,
                              AddProductReviewScreen.name,
                              arguments: widget.productId,
                            );

                            if (newReview != null && mounted) {
                              provider.addNewReview(
                                newReview as ProductReviewModel,
                              );
                            }
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
