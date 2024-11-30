import 'package:shopping_cart/utils/colors.dart';
import 'package:shopping_cart/utils/styles.dart';
import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartCard extends StatelessWidget {
  final CartItem product;
  final Function(int quantity) onQuantityChanged;

  const CartCard({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    double discountAmount = product.price * (product.discountPercentage / 100);
    double actualPrice = product.price - discountAmount;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 166,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: highlightColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: disableColorShade, width: 0.5),
                ),
                child: Image.network(
                  product.thumbnail,
                  height: 160,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: heading18SemiBoldTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
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
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, bottom: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: disableColor2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () => onQuantityChanged(product.quantity - 1),
                                    child: const Icon(Icons.remove, size: 20),
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    width: 16,
                                    child: Center(
                                      child: Text(
                                        '${product.quantity}',
                                        style: heading12SemiBoldTextStyle.copyWith(color: secondaryColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () => onQuantityChanged(product.quantity + 1),
                                    child: const Icon(Icons.add, size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
