import 'package:flutter/material.dart';
import 'package:produto_front/product.dart';

class ProductProvider extends InheritedWidget {
  final Widget child;
  final List<Product> products = [];
  ProductProvider({
    super.key,
    required this.child,
  }) : super(child: child);

  static ProductProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductProvider>();
  }

  @override
  bool updateShouldNotify(ProductProvider widget) {
    return true;
  }
}
