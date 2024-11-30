import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/widgets/cart_card.dart';
import 'package:shopping_cart/utils/colors.dart';
import 'package:shopping_cart/utils/styles.dart';
import '../providers/cart_provider.dart';
import 'package:flutter/material.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        surfaceTintColor: primaryColor,
        title: const Text('Cart', style: heading22SemiBoldTextStyle),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100.0,
                ),
                SizedBox(height: 20),
                Text('Your cart is empty', style: heading18SemiBoldTextStyle),
              ],
            ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return CartCard(
                        product: item,
                        onQuantityChanged: (newQuantity) {
                          if (newQuantity > 0) {
                            ref.read(cartProvider.notifier).updateQuantity(item.id, newQuantity);
                          } else {
                            ref.read(cartProvider.notifier).removeFromCart(item.id);
                          }
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Amount Price", style: heading14RegularTextStyle),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text('₹${totalPrice.toStringAsFixed(2)}', style: heading20SemiBoldTextStyle),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        decoration: BoxDecoration(
                          color: secondaryColor,
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
                        child: Center(
                            child: Row(
                          children: [
                            Text("Check Out", style: heading16SemiBoldTextStyle.copyWith(color: highlightColor)),
                            const SizedBox(width: 4),
                            Container(
                              height: 18,
                              width: 18,
                              decoration: const BoxDecoration(
                                color: highlightColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final totalItemCount = ref.watch(cartProvider.notifier).totalItemCount;
                                    return Text(
                                      totalItemCount.toString(),
                                      style: highlight9RegularTextStyle.copyWith(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
