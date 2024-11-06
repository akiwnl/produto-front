import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final ProductRepository _productRepository = ProductRepository();

  Future<List<Product>> getAllProducts() async {
    try {
      return await _productRepository.getAllProducts();
    } catch (e) {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      return await _productRepository.getProductById(id);
    } catch (e) {
      throw Exception('Falha ao carregar produto');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      return await _productRepository.createProduct(product);
    } catch (e) {
      throw Exception('Falha ao criar produto');
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      return await _productRepository.updateProduct(product);
    } catch (e) {
      throw Exception('Falha ao atualizar produto');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _productRepository.deleteProduct(id);
    } catch (e) {
      throw Exception('Falha ao deletar produto');
    }
  }
}
