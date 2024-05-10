import 'package:buoi_cuoi/data/api.dart';
import 'package:buoi_cuoi/route/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '/model/product.dart';

class ProductAdd extends StatefulWidget {
  final bool isUpdate;
  final Product? productmodel;
  const ProductAdd({super.key, this.isUpdate = false, this.productmodel});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _catController = TextEditingController();
  String titleText = "";

  Product getProduct() {
    Product pro = Product(
      name: _nameController.text,
      price: int.parse(_priceController.text),
      des: _desController.text,
      img: _imgController.text,
      catId: int.parse(_catController.text),
    );
    if (widget.isUpdate) {
      pro.id = widget.productmodel!.id;
    }
    return pro;
  }

  Future<String> addProduct() async {
    return await APIRepository().addProduct(getProduct());
  }

  Future<String> updateProduct() async {
    return await APIRepository().updateProduct(getProduct());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.productmodel != null && widget.isUpdate) {
      _nameController.text = widget.productmodel!.name.toString();
      _priceController.text = widget.productmodel!.price.toString();
      _imgController.text = widget.productmodel!.img.toString();
      _desController.text = widget.productmodel!.des.toString();
      _catController.text = widget.productmodel!.catId.toString();
    }
    if (widget.isUpdate) {
      titleText = "Cập nhật sản phẩm";
    } else {
      titleText = "Thêm sản phẩm mới";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                cursorColor: Color.fromARGB(255, 149, 148, 240),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    hintText: "Nhập tên sản phẩm"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _priceController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  hintText: 'Nhập giá',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _imgController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    hintText: 'Image URL'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                cursorColor: Colors.orange,
                controller: _catController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    hintText: 'Nhập ID'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                cursorColor: Color.fromARGB(255, 149, 148, 240),
                controller: _desController,
                maxLines: 5,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    hintText: 'Nhập mô tả sản phẩm'),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 45,
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
                              future: updateProduct(),
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
                                                      const ProductPage()));
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
                              future: addProduct(),
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
                                                      const ProductPage()));
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
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
