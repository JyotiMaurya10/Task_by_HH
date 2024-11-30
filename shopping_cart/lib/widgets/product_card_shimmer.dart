import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_cart/utils/colors.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Shimmer.fromColors(
                  highlightColor: disableColor,
                  baseColor: disableColor2,
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      color: disableColor2,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  height: 34,
                  width: 76,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 10, top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  highlightColor: disableColor,
                  baseColor: disableColor2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disableColor2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[300],
                      ),
                      height: 20,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  highlightColor: disableColor,
                  baseColor: disableColor2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disableColor2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[300],
                      ),
                      height: 12,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  highlightColor: disableColor,
                  baseColor: disableColor2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disableColor2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[300],
                      ),
                      height: 16,
                      width: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  highlightColor: disableColor,
                  baseColor: disableColor2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disableColor2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[300],
                      ),
                      height: 12,
                      width: 50,
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