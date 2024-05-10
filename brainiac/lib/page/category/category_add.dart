import 'package:buoi_cuoi/data/api.dart';
import 'package:buoi_cuoi/page/category/category_list.dart';
import 'package:buoi_cuoi/route/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/model/category.dart';

class CategoryAdd extends StatefulWidget {
  final bool isUpdate;
  final CategoryModel? categoryModel;
  const CategoryAdd({super.key, this.isUpdate = false, this.categoryModel});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  String titleText = "";

  CategoryModel getCategory() {
    CategoryModel cate = CategoryModel(
        name: _nameController.text,
        desc: _descController.text,
        imageUrl: _imgController.text);
    if (widget.isUpdate) {
      cate.id = widget.categoryModel!.id;
    }
    return cate;
  }

  Future<String> addCategory() async {
    return await APIRepository().addCategory(getCategory());
  }

  Future<String> updateCategory() async {
    return await APIRepository().updateCategory(getCategory());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.categoryModel != null && widget.isUpdate) {
      _nameController.text = widget.categoryModel!.name;
      _descController.text = widget.categoryModel!.desc;
      _imgController.text = widget.categoryModel!.imageUrl!;
    }
    if (widget.isUpdate) {
      titleText = "Cập nhật danh mục";
    } else {
      titleText = "Thêm danh mục mới";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_outlined),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryPage(),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  hintText: 'Nhập tên',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _imgController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  hintText: 'Image URL',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _descController,
                maxLines: 7,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  hintText: 'Nhập mô tả',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 45.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      if (widget.isUpdate) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder(
                              future: updateCategory(),
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
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder(
                              future: addCategory(),
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
                      }
                    },
                    child: const Text(
                      'Hoàn thành',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
