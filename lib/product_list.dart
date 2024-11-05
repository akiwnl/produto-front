import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para decodificar o JSON
import 'package:produto_front/product.dart';
import 'package:produto_front/product_form.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Inicialize diretamente ao declarar
  late Future<List<Product>> _futureProducts = fetchProducts();

  // Função para buscar os produtos da API
  Future<List<Product>> fetchProducts() async {
    const String url =
        'http://10.0.2.2:3000/products'; // Ajuste o URL para o seu backend

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        // Converte o JSON para uma lista de produtos
        return responseData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(
            'Falha ao carregar produtos. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer a requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Produtos'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra um indicador de progresso enquanto carrega
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Exibe uma mensagem de erro se a requisição falhar
            return Center(
              child: Text(
                'Erro ao carregar produtos: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Exibe a lista de produtos se os dados estiverem disponíveis
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext contextBuilder, int indexBuilder) {
                Product product = products[indexBuilder];
                return ListTile(
                  title: Text(product.description),
                  subtitle: Text(
                    'Preço: R\$ ${product.price.toStringAsFixed(2)} - Quantidade: ${product.quantity}',
                  ),
                );
              },
            );
          } else {
            // Exibe uma mensagem se não houver produtos
            return const Center(
              child: Text('Nenhum produto disponível.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de adição de produto
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductForm()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
