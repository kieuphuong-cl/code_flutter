import 'package:buoi_cuoi/mainpage.dart';
import 'package:buoi_cuoi/model/category.dart';
import 'package:buoi_cuoi/page/home.dart';
import 'package:flutter/material.dart';

Widget itemListView(CategoryModel cate, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Mainpage(
              isFilter: true,
              cateID: cate.id,
            ),
          ));
    },
    child: Row(
      children: [
        Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 143, 6),
                borderRadius: BorderRadius.circular(16)),
            child: Image.network(
              cate.imageUrl!,
              height: 10,
              width: 10,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            )),
        const SizedBox(
          width: 6,
        )
      ],
    ),
  );
}
