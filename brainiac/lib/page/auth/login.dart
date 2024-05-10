import 'package:buoi_cuoi/page/auth/forgotpass.dart';
import '/conf/const.dart';
import '/data/api.dart';
import 'register.dart';
import '/mainpage.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository()
        .login(accountController.text, passwordController.text);
    var user = await APIRepository().current(token);
    // save share
    saveID(accountController.text);
    saveUser(user);
    saveToken(token);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Login"),
          ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            Image.asset(
                              urlLogo,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image),
                            ),
                            TextFormField(
                              controller: accountController,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 12, 45, 72), width: 1)),
                                labelText: "ID Tài khoản",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 12, 45, 72)),
                                iconColor: Colors.blue,
                                icon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 12, 45, 72), width: 1)),
                                  labelText: "Mật khẩu",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 12, 45, 72)),
                                  icon: Icon(Icons.password),
                                  iconColor: Colors.blue),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.grey,
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 251, 244),
                                      foregroundColor: Color.fromARGB(255, 12, 45, 72)),
                                  onPressed: login,
                                  child: const Text(
                                    "Đăng nhập",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shadowColor: Colors.grey,
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(
                                          color: Colors.grey, width: 1)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()));
                                  },
                                  child: const Text("Đăng ký"),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotWidget(),
                                      ));
                                },
                                child: const Text(
                                  "Quên mật khẩu ?",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 12, 45, 72),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
