
import 'BasePage.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'Product.dart';

final Logger log = Logger();

class ProductGridViewPage extends StatefulWidget {
  const ProductGridViewPage({super.key});

  @override
  State createState() => ProductGridViewPageState();
}

class ProductGridViewPageState extends State<ProductGridViewPage> {

  List<Product> products = [];
  List<String> routes = ['/', '/product', '/about'];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final String jsonString = await rootBundle.loadString('assets/products.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    var personList = jsonData.map((item) => Product.fromJson(item)).toList();
    setState(() {
      products = personList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = OrientationBuilder(
      builder: (context, orientation) {
        // Check orientation and set crossAxisCount accordingly
        int crossAxisCount = orientation == Orientation.portrait ? 1 : 3;

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 2 / 3, // Adjust ratio for better layout
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                            child: Text('Image not available'));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${product.price.toStringAsFixed(2)} บาท',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    return BasePage(body: body, index: 1);
  }
}


