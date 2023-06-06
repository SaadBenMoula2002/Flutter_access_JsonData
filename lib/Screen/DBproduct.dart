import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp1/Model/Product.dart';
import 'package:http/http.dart' as http;

class DBproduct extends StatefulWidget {
  @override
  State<DBproduct> createState() => _DBproductState();
}

class _DBproductState extends State<DBproduct> {
  TextEditingController idController = TextEditingController();
  String result = '';

  Future<List<Product>> fetchProducts() async {
    String jsonContent = await rootBundle.loadString('lib/Provider/produit.json');
    List<dynamic> productsJson = jsonDecode(jsonContent);
    List<Product> products = productsJson.map((json) => Product.fromJson(json)).toList();
    return products;
  }

  Future<List<Product>> fetchProductsFromServer() async {
    final response = await http.get(Uri.parse('https://my-json-server.typicode.com/SaadBenMoula2002/Products-db/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Product> products = jsonList.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<void> searchProduct() async {
    List<Product> products = await fetchProductsFromServer();

    int? searchId = int.tryParse(idController.text);

    if (searchId != null) {
      Product? product = products.firstWhere(
            (p) => p.id == searchId,
      );

      // ignore: unnecessary_null_comparison
      if (product != null) {
        setState(() {
          result = product.toString();
        });
      } else {
        setState(() {
          result = 'Product Not Found !';
        });
      }
    } else {
      setState(() {
        result = 'Invalid ID !';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Enter product ID',
              ),
            ),
            ElevatedButton(
              onPressed: searchProduct,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}
