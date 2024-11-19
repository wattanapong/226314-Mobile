
import 'package:example/utils/service.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body:  Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('เกี่ยวกับเรา'),
            const SizedBox(height: 20),
            btnPage(context, 'Home', '/'),
            btnPage(context, 'Product', '/product'),
          ],
        )

      ),
    );
  }
}