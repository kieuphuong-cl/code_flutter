import '/page/product/product_add.dart';
import '/page/product/product_data.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 250, 180, 87)),
          child: ProductBuilder()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => const ProductAdd(),
                  fullscreenDialog: true,
                ),
              )
              .then((_) => setState(() {}));
        },
        tooltip: 'Thêm sản phẩm',
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 12, 45, 72),
          size: 32,
        ),
      ),
    );
  }
}
