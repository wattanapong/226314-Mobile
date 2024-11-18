import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'Product.dart';

final Logger log = Logger();
//
Future<List<Product>> fetchProducts() async {
  final String jsonString = await rootBundle.loadString('assets/products.json');
  final List<dynamic> jsonData = jsonDecode(jsonString);
  var personList = jsonData.map((item) => Product.fromJson(item)).toList();

  return personList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<Product> products = await fetchProducts();
  // for(Product product in  products) {
  //   log.d('product: ${product.name}, ${product.price}, ${product.imageUrl}');
  // }

  runApp(Shopping(
    products: products,
  ));
}

class Shopping extends StatelessWidget {
  List<Product> products;
  var itemWidth = 200.0;
  var itemHeight = 200.0;

  Shopping({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    log.d('starting...');

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Shopping ListView')),
      ),
            body: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
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
                            return const Center(child: Text('Image not available'));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${product.price.toStringAsFixed(2)} บาท',
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            )

    ));
  }

}
