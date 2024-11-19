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
      body: OrientationBuilder(
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
      ),
    ));
  }
}
