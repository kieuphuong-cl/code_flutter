import 'dart:convert';
import 'dart:ffi';

import 'package:buoi_cuoi/data/api.dart';
import 'package:buoi_cuoi/mainpage.dart';
import 'package:buoi_cuoi/model/category.dart';
import 'package:buoi_cuoi/model/product.dart';
import 'package:buoi_cuoi/model/user.dart';
import 'package:buoi_cuoi/page/category/categorybody.dart';
import 'package:buoi_cuoi/page/product/productbody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  final bool isFilter;
  final int? cateID;
  const HomeWidget({super.key, this.isFilter = false, this.cateID});
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<CategoryModel> lstCate = [];
  Future<List<CategoryModel>> getCateList() async {
    lstCate = await APIRepository().getCategoryList();
    return lstCate;
  }

  List<Product> lstpro = [];
  Future<List<Product>> getProList() async {
    lstpro = await APIRepository().getProductList();
    return lstpro;
  }

  Future<List<Product>> getProListByID(int cateID) async {
    lstpro = await APIRepository().getProductListByID(cateID);
    return lstpro;
  }

  List<CategoryModel> lst = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryModel cat = CategoryModel(
        name: "Pen", desc: "Pen", imageUrl: "assets/images/pen.png");
    CategoryModel cat2 = CategoryModel(
        name: "Book", desc: "Book", imageUrl: "assets/images/book.png");
    CategoryModel cat3 = CategoryModel(
        name: "Note", desc: "Note", imageUrl: "assets/images/note.png");
    // CategoryModel cat4 = CategoryModel(
    //     name: "Samsung", desc: "Samsung", imageUrl: "assets/images/xiaomi.png");

    getCateList();

    lst.add(cat);
    lst.add(cat2);
    lst.add(cat3);
    // lst.add();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration:
                const BoxDecoration(color: Colors.orange),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: slide(lst),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: categoryList(lstCate),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Builder(
              builder: (context) {
                if (widget.isFilter == true) {
                  return filterProductGrid(lstpro, widget.cateID!);
                } else {
                  return productGrid(lstpro);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget slide(List<CategoryModel> lst) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.5,
        enlargeCenterPage: true,
      ),
      items: lst.map((item) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Mainpage(),
                      ),
                    );
                  },
                  icon: Image.asset(
                    item.imageUrl!,
                    fit: BoxFit.fitHeight,
                    width: 1000.0,
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget productGrid(List<Product> lst) {
    bool isLoading = false;
    return FutureBuilder(
      future: getProList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
          return Container(
            child: const CircularProgressIndicator(),
          );
        }
        isLoading = false;
        return Container(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            itemBuilder: (context, index) {
              return itemGridView(snapshot.data![index]);
            },
          ),
        );
      },
    );
  }

  Widget filterProductGrid(List<Product> lst, int cateID) {
    bool isLoading = false;
    return FutureBuilder(
      future: getProListByID(cateID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
          return Container(
            child: const CircularProgressIndicator(),
          );
        }
        isLoading = false;
        return Container(
          child: GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            itemBuilder: (context, index) {
              return itemGridView(snapshot.data![index]);
            },
          ),
        );
      },
    );
  }

  Widget categoryList(List<CategoryModel> cat) {
    return FutureBuilder(
      future: getCateList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return itemListView(snapshot.data![index], context);
            },
          ),
        );
      },
    );
  }
}
