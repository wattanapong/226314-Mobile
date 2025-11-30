
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Scaffold Row')),
        ),
        body: const Center(
          // child: Column(
          //     children: [
          //       Text('Top'),
          //       Text('Middle'),
          //       Text('Bottom'),
          //     ]
          // ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 20),
                Text('Left  '),
                SizedBox(width: 20),
                Text('Center  '),
                SizedBox(width: 20),
                Text('Right '),
              ]),
        ))));
