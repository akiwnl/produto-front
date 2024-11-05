import 'package:flutter/material.dart';
import 'package:produto_front/product_form.dart';
import 'package:produto_front/product_list.dart';
import 'package:produto_front/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProductProvider(
      child: MaterialApp(
        title: 'Produto Front',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
          ),
        ),
        home: const ProductList(),
        routes: {
          "/listagem": (context) => const ProductList(),
          "/cadastro": (context) => const ProductForm(),
        },
      ),
    );
  }
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Produtos'),
      ),
      body: const Center(
        child: ProductForm(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar um novo produto
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
