import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/providers/cart_provider.dart';
import 'package:shopping_cart/screens/cart_screen.dart';
import 'package:shopping_cart/utils/colors.dart';
import 'package:shopping_cart/utils/styles.dart';
import 'package:shopping_cart/widgets/product_card_shimmer.dart';
import '../providers/products_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

class ProductCatalogueScreen extends ConsumerStatefulWidget {
  const ProductCatalogueScreen({super.key});
  @override
  ConsumerState<ProductCatalogueScreen> createState() => _ProductCatalogueScreenState();
}

class _ProductCatalogueScreenState extends ConsumerState<ProductCatalogueScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(productsProvider.notifier).fetchProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 20) {
        final isLoading = ref.read(isLoadingProvider);
        if (!isLoading) {
          ref.read(isLoadingProvider.notifier).state = true;

          ref.read(productsProvider.notifier).fetchProducts().then((_) {
            ref.read(isLoadingProvider.notifier).state = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);
    final cartItemCount = cart.fold(0, (total, item) => total + item.quantity);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          surfaceTintColor: primaryColor,
          title: const Text('Catalogue', style: heading22SemiBoldTextStyle),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 28.0,
                    ),
                    Positioned(
                      right: -5,
                      top: -5,
                      child: Container(
                        height: 18,
                        width: 18,
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cartItemCount.toString().padLeft(2, '0'),
                            style: highlight9RegularTextStyle.copyWith(
                              fontSize: 8,
                              color: highlightColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: products.isEmpty
            ? GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 0.627,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const ProductCardShimmer();
                },
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Column(children: [
                    Expanded(
                        child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.627,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    )),
                  ]),
                  Positioned(
                    bottom: 16.0,
                    child: AnimatedOpacity(
                      opacity: isLoading ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(32)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: highlightColor,
                                )),
                            const SizedBox(width: 10),
                            Text(
                              "loading more...",
                              style: heading12RegularTextStyle.copyWith(fontWeight: FontWeight.bold, color: highlightColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
