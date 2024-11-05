import 'package:flutter/material.dart';
import 'package:produto_front/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para codificar/decodificar JSON

class ProductProvider extends InheritedWidget {
  final Widget child;
  final List<Product> products = [];
  ProductProvider({
    super.key,
    required this.child,
  }) : super(child: child);

  Future<void> addProduct(Map<String, dynamic> productData) async {       
    const String url = 'http://10.0.2.2:3000/products';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Importante para o backend interpretar como JSON
        },
        body: jsonEncode(productData), // Converte o mapa de dados para JSON
      );

      if (response.statusCode == 201) {
        // Sucesso, o produto foi salvo no backend
        print('Produto salvo com sucesso!');
      } else {
        // Se houve um erro, mostre o status code
        print('Falha ao salvar o produto. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  static ProductProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductProvider>();
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) {
    return true;
  }
}
