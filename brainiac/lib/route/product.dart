import 'package:buoi_cuoi/page/product/product_data.dart';
import 'package:buoi_cuoi/page/product/product_list.dart';
import 'package:flutter/material.dart';

import '../mainpage.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_outlined),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Mainpage(),
              )),
        ),
      ),
      body: const ProductList(),
    );
  }
}
