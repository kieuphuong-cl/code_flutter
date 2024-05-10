import 'package:flutter/cupertino.dart';
import '../../model/product_viewmodel.dart';
import '/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../conf/const.dart';
import 'package:intl/intl.dart';

Widget itemGridView(Product pro) {
  return Container(
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      border: Border.all(color: Colors.lightBlue, width: 1.5),
    ),
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Image.network(
                pro.img!,
                height: 100,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
              ),
            ),
            Text(
              pro.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              NumberFormat('###,###,###').format(pro.price),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              selectionColor: Color.fromARGB(255, 0, 0, 1),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 26),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Consumer<ProductVM>(
                    builder: (context, value, child) => IconButton(
                      onPressed: () {
                        value.add(pro);
                      },
                      icon: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_checkout_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Mua hàng",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            onPressed: () {
              // Handle heart icon tap
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}
