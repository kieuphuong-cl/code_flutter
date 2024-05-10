import 'package:buoi_cuoi/mainpage.dart';
import 'package:buoi_cuoi/page/defaultwidget.dart';
import 'package:buoi_cuoi/page/home.dart';
import 'package:buoi_cuoi/route/category.dart';
import 'package:buoi_cuoi/route/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/page/auth/login.dart';
import 'model/product_viewmodel.dart';
 
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductVM(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
} 
