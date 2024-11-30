import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/models/cart_model.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + item.quantity,
      );
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedItem else state[i],
      ];
    } else {
      state = [...state, item];
    }
  }

  void removeFromCart(int id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateQuantity(int id, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(id);
    } else {
      final index = state.indexWhere((item) => item.id == id);
      if (index != -1) {
        final updatedItem = state[index].copyWith(quantity: newQuantity);
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index) updatedItem else state[i],
        ];
      }
    }
  }

  bool isInCart(int id) {
    return state.any((item) => item.id == id);
  }
 
  int get totalItemCount {
    return state.fold(0, (count, item) => count + item.quantity);
  }

  double get totalPrice {
    return state.fold(0, (total, item) {
      double discountAmount = item.price * (item.discountPercentage / 100);
      double actualPrice = item.price - discountAmount;
      return total + actualPrice * item.quantity;
    });
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
final isLoadingProvider = StateProvider<bool>((ref) => false);
