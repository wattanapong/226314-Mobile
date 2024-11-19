
import 'package:flutter/material.dart';

Widget btnPage(BuildContext context, String text, String route) {
  return ElevatedButton(
    child: Text(text),
    onPressed: () {
      Navigator.pushNamed(context, route);
    },
  );
}