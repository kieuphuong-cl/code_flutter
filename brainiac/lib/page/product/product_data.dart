import 'package:buoi_cuoi/route/product.dart';

import '../../data/api.dart';
import '/model/product.dart';
import '/page/product/product_add.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../conf/const.dart';

class ProductBuilder extends StatefulWidget {
  const ProductBuilder({super.key});

  @override
  State<ProductBuilder> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends State<ProductBuilder> {
  List<Product> lstpro = [];
  Future<List<Product>> getProList() async {
    lstpro = await APIRepository().getProductList();
    return lstpro;
  }

  Future<String> removeProduct(int productID) async {
    return await APIRepository().deleteProduct(productID);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: getProList(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: lstpro.length,
              itemBuilder: (context, index) {
                return _buildProduct(lstpro[index], context);
              },
            );
          },
        ));
  }

  Widget _buildProduct(Product pro, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
                height: 80.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: Image.network(
                  pro.img!,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                )),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pro.name}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "${NumberFormat('###,###,###').format(pro.price)} VND",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${pro.des}',
                  )
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
                                      future: removeProduct(pro.id!),
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
                            builder: (_) => ProductAdd(
                              isUpdate: true,
                              productmodel: pro,
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
