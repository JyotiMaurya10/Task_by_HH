import 'package:shopping_cart/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/utils/colors.dart';
import 'package:shopping_cart/utils/styles.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double discountAmount = product.price * (product.discountPercentage / 100);
    double actualPrice = product.price - discountAmount;
    final isInCart = ref.read(cartProvider.notifier).isInCart(product.id);

    return Container(
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: disableColorShade, width: 0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.thumbnail,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (!isInCart)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(cartProvider.notifier).addToCart(
                                CartItem(
                                    id: product.id,
                                    title: product.title,
                                    thumbnail: product.thumbnail,
                                    price: product.price,
                                    quantity: 1,
                                    discountPercentage: product.discountPercentage,
                                    brand: product.brand),
                              );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: headingColor.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(child: Text("Add", style: heading12SemiBoldTextStyle.copyWith(color: secondaryColor))),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: heading18SemiBoldTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6),
                  child: Text(
                    product.brand ?? " ",
                    style: heading12RegularTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '₹${product.price.toStringAsFixed(2)}',
                        style: heading10RegularTextStyle.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: ' ₹${actualPrice.toStringAsFixed(2)}',
                        style: heading14SemiBoldTextStyle.copyWith(letterSpacing: 1.3),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${product.discountPercentage}',
                          style: heading10SemiBoldTextStyle.copyWith(color: secondaryColor, letterSpacing: 1.5),
                        ),
                        TextSpan(
                          text: '% OFF',
                          style: heading12SemiBoldTextStyle.copyWith(color: secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
