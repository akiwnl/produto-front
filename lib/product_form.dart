import 'package:flutter/material.dart';
import 'package:produto_front/field_form.dart';
import 'package:produto_front/product.dart';
import 'package:produto_front/product_provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void save() {
      ProductProvider productProvider =
          ProductProvider.of(context) as ProductProvider;

      // Criação do produto com os dados do formulário
      Product product = Product(
        description: controllerDescription.text,
        price: double.parse(controllerPrice.text),
        quantity: int.parse(controllerQuantity.text),
      );

      // Criar o mapa de dados do produto para o backend
      Map<String, dynamic> productData = {
        'description': product.description,
        'price': product.price,
        'quantity': product.quantity,
      };

      // Enviar o produto ao backend
      productProvider.addProduct(productData);
      Navigator.pushReplacementNamed(context, "/listagem");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FieldForm(
                      label: "Nome do Produto",
                      controller: controllerDescription),
                  const SizedBox(height: 16),
                  FieldForm(label: "Preço", controller: controllerPrice),
                  const SizedBox(height: 16),
                  FieldForm(
                      label: "Quantidade", controller: controllerQuantity),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Enviar",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
