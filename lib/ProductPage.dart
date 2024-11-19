
import 'package:example/utils/service.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body:  Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('เลือกสินค้าที่คุณต้องการซื้อ'),
            const SizedBox(height: 20),
            btnPage(context, 'Home', '/'),
            btnPage(context, 'About', '/about'),
          ],
        )

      ),
    );
  }
}