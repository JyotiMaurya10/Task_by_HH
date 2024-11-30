import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/product_catalogue_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const ProductCatalogueScreen(),
    );
  }
}
