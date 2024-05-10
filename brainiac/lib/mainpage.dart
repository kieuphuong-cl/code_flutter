import 'dart:convert';
import 'package:buoi_cuoi/page/favorites.dart';
import 'package:buoi_cuoi/page/history.dart';
import 'package:buoi_cuoi/page/home.dart';
import 'package:provider/provider.dart';
import '/model/category.dart';
import '/model/user.dart';
import '/page/detail.dart';
import 'model/cartcounter.dart';
import 'model/product_viewmodel.dart';
import 'page/cart.dart';
import 'route/category.dart';
import 'route/product.dart';
import 'route/favortites.dart';
import 'package:flutter/material.dart';
import '/page/defaultwidget.dart';
import '/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  final bool isFilter;
  final int? cateID;
  const Mainpage({super.key, this.isFilter = false, this.cateID});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    print(user.imageURL);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index, bool isfilter, int cateId) {
    var nameWidgets = "Home";
    Widget widget = const HomeWidget();
    switch (index) {
      case 0:
        nameWidgets = "Home";
        widget = HomeWidget(
          isFilter: isfilter,
          cateID: cateId,
        );
        break;
      case 1:
        nameWidgets = "History";
        widget = const HistoryWidget();
        break;
      case 2:
        nameWidgets = "Favorite";
        widget = const FavoritesWidget();
        break;
      case 3:
        nameWidgets = "Cart";
        widget = const CartWidget();
        break;
      case 4:
        {
          return const Detail();
        }
      case 5:
        nameWidgets = "Home";
        widget = HomeWidget(
          isFilter: isfilter,
          cateID: cateId,
        );
        break;
      default:
        nameWidgets = "None";
        widget = const HomeWidget();
        break;
    }
    return DefaultWidget(
      title: nameWidgets,
      widget: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Text("HL Mobile"),
            // const SizedBox(width: 2),
            // const Spacer(),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 10,
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              _onItemTapped(2);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 24,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 10,
                    right: 0,
                    child: Consumer<ProductVM>(
                      builder: (context, value, child) =>
                          CartCounter(count: value.count.toString()),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 186, 112),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.imageURL!.length < 5
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            user.imageURL!,
                          )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(user.fullName!),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Lịch sử'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Giỏ hàng'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Danh mục'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_android_sharp),
              title: const Text('Sản phẩm'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Yêu thích'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FavoritePage()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId == ''
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Đăng xuất'),
                    onTap: () {
                      logOut(context);
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    left: 9,
                    top: -4,
                    child: Consumer<ProductVM>(
                      builder: (context, value, child) =>
                          CartCounter(count: value.count.toString()),
                    ),
                  )
                ],
              ),
              label: "Giở hàng"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Thông tin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex, widget.isFilter, widget.cateID ?? 0),
    );
  }
}
