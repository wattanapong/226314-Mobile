
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Scaffold Row')),
        ),
        body: Center(
          // child: Column(
          //     children: [
          //       Text('Top'),
          //       Text('Middle'),
          //       Text('Bottom'),
          //     ]
          // ),
          child: Column(
          // main = แกนตั้ง, cross = แกนนอน
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ชื่อสินค้า',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),   // เว้นระยะ
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text('ราคา'),
            //     Text('11,590 บาท'),
            //   ],
            // ),
              // Row with Expanded
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: const Text(
                          'Expanded',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),

          ],
)

        ))));
