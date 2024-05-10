import 'package:buoi_cuoi/mainpage.dart';
import 'package:buoi_cuoi/page/category/category_list.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_outlined),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Mainpage(),
              )),
        ),
      ),
      body: const CategoryList(),
    );
  }
}
