import 'package:flutter/material.dart';

import 'add_details.dart';
import 'add_product.dart';
import 'home_page.dart';
import 'next_page.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        "/": (context) => HomePage(),
        "add_product": (context) => AddProduct(),
        "add_details": (context) => AddDetails(),
        "next_page": (context) => NextPage(),
      },
    ),
  );
}
