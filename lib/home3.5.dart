
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Scaffold Row')),
      ),
      body: Center(
        child: Column(
          // main = vertical axis, cross = horizontal axis
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ชื่อสินค้า',
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 8),

            // Product Image with Stack
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    'https://img.advice.co.th/images_nas/pic_product4/A0156727/A0156727_1.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),

                  // SALE label
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: Colors.red,
                      child: const Text(
                        'SALE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Favorite icon
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);