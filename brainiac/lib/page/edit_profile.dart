import '../model/edit.dart';
import '/data/api.dart';
import '/model/register.dart';
import '/page/auth/login.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  @override
  void initState() {
    super.initState();
  }
// void initState() {
//   super.initState();
//   _fullNameController.text = widget.user.fullName ?? '';
//   _numberIDController.text = widget.user.numberID ?? '';
//   _phoneNumberController.text = widget.user.phoneNumber ?? '';
//   _schoolKeyController.text = widget.user.schoolKey ?? '';
//   _schoolYearController.text = widget.user.schoolYear ?? '';
//   _birthDayController.text = widget.user.birthDay ?? '';
//   _imageURL.text = widget.user.imageURL ?? '';
// }

  Future<String> updateProfile() async {
    return await APIRepository().updateProfile(Signup(
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
        title: const Text("Chỉnh sửa thông tin"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textField(_fullNameController, "Họ và tên", Icons.person),
              textField(_numberIDController, "Số CMND", Icons.person_outline),
              textField(_phoneNumberController, "Số điện thoại", Icons.phone),
              textField(_schoolKeyController, "Mã trường", Icons.school),
              textField(_schoolYearController, "Năm học", Icons.calendar_today),
              textField(_birthDayController, "Ngày sinh", Icons.date_range),
              const SizedBox(height: 16),
              const Text(
                "Giới tính",
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Nam",
                          style: TextStyle(color: Colors.orange)),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 1,
                          activeColor: Colors.orange,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Nữ",
                          style: TextStyle(color: Colors.orange)),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 2,
                          activeColor: Colors.orange,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Khác",
                          style: TextStyle(color: Colors.orange)),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 3,
                          activeColor: Colors.orange,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              textField(_imageURL, "URL ảnh đại diện", Icons.image),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String response = await updateProfile();
                  if (response == "ok") {
                    // Nếu cập nhật thông tin thành công, quay trở lại màn hình trước đó
                    Navigator.pop(context);
                  } else {
                    print(response);
                  }
                },
                child: const Text("Lưu thay đổi"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getGender() {
    if (_gender == 1) {
      return "Male";
    } else if (_gender == 2) {
      return "Female";
    }
    return "Other";
  }

  Widget textField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.orange,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon, color: Colors.orange),
        ),
      ),
    );
  }
}
