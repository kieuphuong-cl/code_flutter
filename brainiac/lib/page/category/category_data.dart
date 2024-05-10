import 'dart:ffi';

import 'package:buoi_cuoi/route/category.dart';
import 'package:flutter/material.dart';
import '../../data/api.dart';
import '/model/category.dart';

import 'category_add.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder({
    super.key,
  });

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  List<CategoryModel> lstCate = [];
  Future<List<CategoryModel>> getCateList() async {
    // getDataUser();
    lstCate = await APIRepository().getCategoryList();
    return lstCate;
  }

  Future<String> removeCate(int categoryID) async {
    return await APIRepository().deleteCategory(categoryID);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCateList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCateList(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: lstCate.length,
            itemBuilder: (context, index) {
              return _buildCategory(lstCate[index], context);
            },
          ),
        );
      },
    );
  }

  Widget _buildCategory(CategoryModel breed, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: Image.network(
                  breed.imageUrl!,
                  height: 30,
                  width: 30,
                )),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    breed.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(breed.desc),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            "Bạn chắc chắn muốn xoá?"),
                        title: const Text("Thông báo"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return FutureBuilder(
                                      future: removeCate(breed.id!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return AlertDialog(
                                          content: Text(snapshot.data!),
                                          title: const Text("Thông báo"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const CategoryPage()));
                                                },
                                                child: const Text("Ok"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text("Có")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Huỷ")),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 12, 45, 72),
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (_) => CategoryAdd(
                              isUpdate: true,
                              categoryModel: breed,
                            ),
                            fullscreenDialog: true,
                          ),
                        )
                        .then((_) => setState(() {}));
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 12, 45, 72),
                ))
          ],
        ),
      ),
    );
  }
}
