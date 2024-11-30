import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'dart:convert';

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  int skip = 0;
  final int limit = 8;
  bool isLoading = false;
  bool hasMoreData = true;

  bool get hasMore => hasMoreData;

  Future<void> fetchProducts() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    try {
      final url = 'https://dummyjson.com/products?skip=$skip&limit=$limit';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List productsJson = json.decode(response.body)['products'];
        if (productsJson.isEmpty) {
          hasMoreData = false;
        } else {
          state = [...state, ...productsJson.map((json) => Product.fromJson(json)).toList()];
          skip += limit;
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }
}

final productsProvider = StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  return ProductsNotifier();
});