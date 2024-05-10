import '/data/api.dart';
import '/page/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotWidget extends StatefulWidget {
  const ForgotWidget({super.key});

  @override
  State<ForgotWidget> createState() => _ForgotWidgetState();
}

class _ForgotWidgetState extends State<ForgotWidget> {
  TextEditingController accountController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController newpassController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  String status = "";
  Future<String> forgotPass(
      String accountID, String numberID, String newpass) async {
    return await APIRepository().forgotPass(accountID, numberID, newpass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quên mật khẩu"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: accountController,
                                    cursorColor: Colors.orange,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      labelText: "ID Tài khoản",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 45, 72)),
                                      iconColor: Colors.blue,
                                      icon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: numberController,
                                    cursorColor: Colors.blue,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      labelText: "Số điện thoại",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 45, 72)),
                                      iconColor: Colors.blue,
                                      icon: Icon(Icons.perm_identity_sharp),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: newpassController,
                                    obscureText: true,
                                    cursorColor: Colors.blue,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1)),
                                        labelText: "Mật khẩu mới",
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 12, 45, 72)),
                                        icon: Icon(Icons.password),
                                        iconColor: Colors.blue),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 128),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.grey,
                                                backgroundColor: Color.fromARGB(255, 184, 184, 184),
                                                foregroundColor: Color.fromARGB(
                                                    255, 107, 74, 24)),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return FutureBuilder(
                                                      future: forgotPass(
                                                          accountController
                                                              .text,
                                                          numberController
                                                              .text,
                                                          newpassController
                                                              .text),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        return AlertDialog(
                                                          content: Text(
                                                              snapshot.data!),
                                                          title: const Text(
                                                              "Thông báo"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginScreen(),
                                                                      ));
                                                                },
                                                                child:
                                                                    Text("Ok"))
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  });
                                            },
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
