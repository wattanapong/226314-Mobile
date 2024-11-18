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
  for(Product product in  products) {
    log.d('product: ${product.name}, ${product.price}, ${product.imageUrl}');
  }

  runApp(Shopping(products: products,));
}

class Shopping extends StatelessWidget {
  List<Product> products;
  var itemWidth = 200.0;
  var itemHeight = 200.0;

  Shopping({super.key, required this.products});

  @override
  Widget build(BuildContext context) {

    log.d('starting...');

    var orientation = MediaQuery.of(context).orientation;
    Widget layout = layoutPortrait();
    Axis direction = Axis.vertical;

    if (orientation == Orientation.landscape) {
      layout = layoutLandscape();
      direction = Axis.horizontal;
    }

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Shopping List')),
          ),
          body: Center( child: SingleChildScrollView(
            scrollDirection: direction,
            padding: const EdgeInsets.all(20),
            child: Center(child: layout),
          ),
          ),
        ));
  }

  Widget layoutLandscape() {
    return
          Row(
          children: [
            box('1', itemWidth, itemHeight, products[0]),
            box('2', itemWidth, itemHeight, products[1]),
            box('3', itemWidth, itemHeight, products[2]),
          ],
        );
  }

  Widget layoutPortrait() {
    return Column(
      children: [
        box('1', itemWidth, itemHeight, products[0]),
        box('2', itemWidth, itemHeight, products[1]),
        box('3', itemWidth, itemHeight, products[2]),
      ],
    );
  }

  Widget box(text, w, h, product) {
    return Container(
      width: w,
      height: h,
      alignment: Alignment.center,
      child: Column(
          children: [
        Image.network(
          product.imageUrl,
          width: w,
          height: h-50,
        ),
        Text(product.name, textScaler: const TextScaler.linear(0.9), style: const TextStyle(color: Colors.blue))
      ]
      )
    );
  }
}
