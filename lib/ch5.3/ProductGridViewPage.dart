
import 'package:mobile_software_development/ch5.2/BasePage.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'Product.dart';

import 'package:http/http.dart' as http;

final Logger log = Logger();

class ProductGridViewPage extends StatefulWidget {
  @override
  State createState() => ProductGridViewPageState();
}

class ProductGridViewPageState extends State<ProductGridViewPage> {

  List<Product> products = [];
  List<String> routes = ['/', '/product', '/about'];
  List<Map<String, String>> menus = [
    {'menu': '22791', 'key': '5'},
    {'menu': '22796', 'key': '6'},
    {'menu': '22807', 'key': '7'},
    {'menu': '22812', 'key': '8'},
    {'menu': '22816', 'key': '9'},
  ];

  @override
  void initState()  {
    super.initState();
    final Map<String, String> requestBody = {
      'menu_level': '2',
      'menu': '22816',
        'skip': '0',
        'take': '16',
        'key': '9',
        'sort_promotion': '',
        'product_type': 'product',
    };

    String url = 'https://www.advice.co.th/avi/getProduct';

    try {
      fetchProducts(url, requestBody);
      // log.d(products);
    } catch (e) {
      log.e('Error fetching data: $e');
    }

  }

  Future<void> fetchProducts(String url, Map<String, String> body) async {
    final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      // return jsonDecode(response.body);
      final Map<String, dynamic> allData = jsonDecode(response.body);

      final List<dynamic> resData = allData['res'];

      List<Product> productMap = [];
      for(Map<String,dynamic> item in resData) {
        productMap.add(Product(
            name: item['item_name'],
            price: item['item_saleprice'].toDouble(),
            imageUrl: item['item_img'],
          ));
      }

      setState(() {
        products = productMap;
      });

    } else {
      throw Exception('Failed to fetch data');
    }

  }

  @override
  Widget build(BuildContext context)  {

    log.d('product length is ${products.length}');

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
                      fit: BoxFit.contain,
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


