
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(;
    home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Scaffold Row')),
        ),
        body: Center(

          child: Column(
          // main = แกนตั้ง, cross = แกนนอน
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ชื่อสินค้า',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),   // เว้นระยะ
 
              // Row with Expanded
              SizedBox(
                height: 80,
                child: Row(
                  Stack(
                    children: [
                      Image.network('https://img.advice.co.th/images_nas/pic_product4/A0156727/A0156727_1.jpg', width: 200, height: 200),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          color: Colors.red,
                          child: const Text('SALE',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.favorite_border),
                      ),
                    ],
                  )

              ),

          ],
)

        ))));
