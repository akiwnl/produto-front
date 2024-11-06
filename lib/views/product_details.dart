import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'product_form.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({required this.product});

  final ProductService _productService = ProductService();

  String getFormattedDate() {
    final brasilia = tz.getLocation('America/Sao_Paulo');
    final brTime = tz.TZDateTime.from(product.createdAt.toUtc(), brasilia);
    return DateFormat('dd/MM/yyyy HH:mm').format(brTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Produto',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductForm(product: product),
                ),
              ).then((value) {
                if (value != null) {
                  Navigator.of(context).pop(true);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool confirmed = await _confirmDelete(context);
              if (confirmed) {
                await _deleteProduct(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.description,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Preço: R\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Quantidade: ${product.quantity}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Criado em: ${getFormattedDate()}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Deletar produto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              content: Text(
                'Tem certeza de que deseja deletar este produto?',
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(
                    'Deletar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // Método para deletar o produto
  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await _productService.deleteProduct(product.id);
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao deletar produto')),
      );
    }
  }
}
