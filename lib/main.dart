import 'package:flutter/material.dart';
import 'views/product_list.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}
