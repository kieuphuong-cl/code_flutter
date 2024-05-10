import 'package:buoi_cuoi/color/color.dart';
import 'package:buoi_cuoi/data/api.dart';
import 'package:buoi_cuoi/mainpage.dart';
import 'package:buoi_cuoi/model/bill.dart';
import 'package:buoi_cuoi/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/product_viewmodel.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  var lstProStr = "";
  List<Bill> lstBill = [];
  Future<String> Payment() async {
    await APIRepository().toBill(lstBill);
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Consumer<ProductVM>(
          builder: (context, value, child) => Scaffold(
            body: SafeArea(
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 250, 180, 87)),
                  child: ListView.builder(
                    itemCount: value.lst.length,
                    itemBuilder: (context, index) {
                      return itemListView(
                          value.lst[index], value.amounts[index]);
                    },
                  ),
                ),
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<ProductVM>(
                        builder: (context, value, child) => Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Xác nhận'),
                                            content: const Text(
                                                "Bạn chắc chắn muốn xoá?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Huỷ'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Xoá'),
                                                onPressed: () {
                                                  value.delAll();
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: const Text(
                                                        'Đã xoá thành công'),
                                                    duration: const Duration(
                                                        seconds: 25),
                                                  ));
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                    // value.delAll();
                                  },
                                  icon: const Icon(Icons.close)),
                            )),
                    const SizedBox(
                      width: 285,
                    ),
                    Consumer<ProductVM>(
                        builder: (context, value, child) => Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 214, 212, 212),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    for (int i = 0; i < value.lst.length; i++) {
                                      Bill bill = Bill(
                                          proID: value.lst[i].id,
                                          count: value.amounts[i]);
                                      lstBill.add(bill);
                                    }
                                    Payment();
                                    value.delAll();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Mainpage(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Thanh toán thành công'),
                                        duration: Duration(seconds: 25),
                                      ),
                                    );
                                  },
                                  icon:
                                      const Icon(Icons.shopping_cart_checkout)),
                            )),
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

Widget itemListView(Product pro, int amount) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(left: 4, right: 4, top: 16, bottom: 0),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          pro.img!,
          height: 50,
          width: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pro.name ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                NumberFormat('###,###,###').format(pro.price),
                style: const TextStyle(fontSize: 15, color: Colors.red),
              ),
              Text(
                pro.des!,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Consumer<ProductVM>(
                builder: (context, value, child) => Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          value.delPro(pro);
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.white,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 6),
              child: Text("$amount"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Consumer<ProductVM>(
                builder: (context, value, child) => Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          value.add(pro);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ))),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
