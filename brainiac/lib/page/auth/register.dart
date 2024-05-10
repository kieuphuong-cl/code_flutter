import '/data/api.dart';
import '/model/register.dart';
import '/page/auth/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _gender = 0;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  String gendername = 'None';
  String temp = '';

  Future<String> register() async {
    return await APIRepository().register(Signup(
        accountID: _accountController.text,
        birthDay: _birthDayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        schoolKey: _schoolKeyController.text,
        schoolYear: _schoolYearController.text,
        gender: getGender(),
        imageUrl: _imageURL.text,
        numberID: _numberIDController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Đăng ký"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Expanded(
                    flex: 1,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.orange,
                      // ),
                      child: Column(
                        children: [
                          // Expanded(
                          //     flex: 1,
                          //     child: Container(
                          //       alignment: Alignment.topLeft,
                          //       padding: EdgeInsets.all(16),
                          //       decoration: BoxDecoration(color: Colors.orange),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "Register",
                          //             style: TextStyle(
                          //                 color: Colors.white, fontSize: 30),
                          //           ),
                          //           Text(
                          //             "Create an account",
                          //             style: TextStyle(
                          //                 color: Colors.white, fontSize: 16),
                          //           )
                          //         ],
                          //       ),
                          //     )),
                          Expanded(
                              flex: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      signUpWidget(),
                                      const SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                shadowColor: Colors.grey,
                                                foregroundColor: Colors.black,
                                              ),
                                              onPressed: () async {
                                                String respone =
                                                    await register();
                                                if (respone == "ok") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginScreen()));
                                                } else {
                                                  print(respone);
                                                }
                                              },
                                              child: const Text('Đăng ký'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )),
              ),
            )
          ],
        ));
  }

  getGender() {
    if (_gender == 1) {
      return "Nam";
    } else if (_gender == 2) {
      return "Nữ";
    }
    return "Khác";
  }

  //có thể thêm các biến cho phù hợp với từng field
  Widget textField(
      TextEditingController controller, String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: label.contains('word'),
        onChanged: (value) {
          setState(() {
            temp = value;
          });
        },
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            labelText: label,
            labelStyle: TextStyle(color: Color.fromARGB(255, 12, 45, 72)),
            iconColor: Colors.blue,
            icon: Icon(icon),
            errorText: controller.text.trim().isEmpty ? 'Vui lòng nhập' : null,
            focusedErrorBorder: controller.text.isEmpty
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 12, 45, 72)))
                : null,
            errorBorder: controller.text.isEmpty
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 12, 45, 72)))
                : null),
      ),
    );
  }

  Widget signUpWidget() {
    return Column(
      children: [
        textField(_accountController, "Account", Icons.person),
        textField(_passwordController, "Password", Icons.password),
        textField(
          _confirmPasswordController,
          "Confirm password",
          Icons.password,
        ),
        textField(_fullNameController, "Full Name", Icons.text_fields_outlined),
        textField(_numberIDController, "NumberID", Icons.key),
        textField(_phoneNumberController, "PhoneNumber", Icons.phone),
        textField(_birthDayController, "BirthDay", Icons.date_range),
        textField(_schoolYearController, "SchoolYear", Icons.school),
        textField(_schoolKeyController, "SchoolKey", Icons.school),
        const Text(
          "What is your Gender?",
          style: TextStyle(color: Color.fromARGB(255, 12, 45, 72), fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  "Nam",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.translate(
                    offset: const Offset(16, 0),
                    child: Radio(
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    )),
              ),
            ),
            Expanded(
              child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Nữ",
                      style: TextStyle(color: Colors.black)),
                  leading: Transform.translate(
                    offset: const Offset(16, 0),
                    child: Radio(
                      value: 2,
                      activeColor: Colors.black,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  )),
            ),
            Expanded(
                child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title:
                  const Text("Khác", style: TextStyle(color: Colors.black)),
              leading: Transform.translate(
                  offset: const Offset(16, 0),
                  child: Radio(
                    value: 3,
                    activeColor: Colors.black,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  )),
            )),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _imageURL,
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            labelText: "Image URL",
            icon: Icon(
              Icons.image,
              color: Color.fromARGB(255, 12, 45, 72),
            ),
          ),
        ),
      ],
    );
  }
}
