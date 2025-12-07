
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
  int _currentIndex = 1;
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
    log.d('starting...');

    List<String> routes = ['/', '/product', '/about'];

    // final index = ModalRoute.of(context)?.settings.arguments as int;
    // _currentIndex = index??0;

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

            bottomNavigationBar:
            BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Colors.amber[800],
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront),
                  label: 'Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'About',
                ),
              ],
              onTap: (index) =>
                  setState(() {
                    _currentIndex = index;
                    Navigator.pushNamed(context, routes[index]);
                  }),
            )
        )
        );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Product'),
  //     ),
  //     body:  Center(
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 20),
  //           const Text('เลือกสินค้าที่คุณต้องการซื้อ'),
  //           const SizedBox(height: 20),
  //           btnPage(context, 'Home', '/'),
  //           btnPage(context, 'About', '/about'),
  //         ],
  //       )
  //
  //     ),
  //   );
  // }
}