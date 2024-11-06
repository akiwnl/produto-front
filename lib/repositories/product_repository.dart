import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  final String baseUrl = 'http://localhost:3000/products';

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        print(
            'Erro ao carregar produtos: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao carregar produtos');
      }
    } catch (e) {
      print('Erro inesperado ao carregar produtos: $e');
      rethrow;
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        print(
            'Erro ao carregar produto com ID $id: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao carregar produto');
      }
    } catch (e) {
      print('Erro inesperado ao carregar produto com ID $id: $e');
      rethrow;
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 201) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        print(
            'Erro ao criar produto: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao criar produto');
      }
    } catch (e) {
      print('Erro inesperado ao criar produto: $e');
      rethrow;
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        print(
            'Erro ao atualizar produto com ID ${product.id}: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao atualizar produto');
      }
    } catch (e) {
      print('Erro inesperado ao atualizar produto com ID ${product.id}: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 204) {
        print(
            'Erro ao deletar produto com ID $id: ${response.statusCode} - ${response.body}');
        throw Exception('Falha ao deletar produto');
      }
    } catch (e) {
      print('Erro inesperado ao deletar produto com ID $id: $e');
      rethrow;
    }
  }
}
