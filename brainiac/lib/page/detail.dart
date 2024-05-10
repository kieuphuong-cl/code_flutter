import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../color/color.dart';
import '../model/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  User user = User.userEmpty();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAppWhite,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFormAvatar(user.imageURL),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildFormInfomation(),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Xử lý hành động khi nút "Edit" được nhấn
                        // Ví dụ: mở màn hình chỉnh sửa thông tin người dùng
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(user: user)),
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: Text('Edit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormAvatar(String? imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [mainAppWhite, mainAppWhite]),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildAvatar(imageUrl ?? ''),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: mainAppWhite,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          imageUrl,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            );
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }

  Widget _buildFormInfomation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: TextStyle(
            color: orangeLight,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: mainorange, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${user.fullName}',
                    style: TextStyle(
                      color: mainAppBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${user.numberID}',
                    style: TextStyle(
                      color: greyColorForText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: mainAppBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${user.phoneNumber}',
                    style: TextStyle(
                      fontSize: 16,
                      color: mainAppBlack,
                    ),
                  ),
                ],
              ),
              Divider(color: greyDivier),
              Row(
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                        fontSize: 16,
                        color: mainAppBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${user.gender}',
                    style: TextStyle(
                      fontSize: 16,
                      color: mainAppBlack,
                    ),
                  ),
                ],
              ),
              Divider(color: greyDivier),
              Row(
                children: [
                  Text(
                    'Birthday',
                    style: TextStyle(
                        fontSize: 16,
                        color: mainAppBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${user.birthDay}',
                    style: TextStyle(
                      fontSize: 16,
                      color: mainAppBlack,
                    ),
                  ),
                ],
              ),
              Divider(color: greyDivier),
              Row(
                children: [
                  Text(
                    'School Year',
                    style: TextStyle(
                        fontSize: 16,
                        color: mainAppBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${user.schoolYear}',
                    style: TextStyle(
                      fontSize: 16,
                      color: mainAppBlack,
                    ),
                  ),
                ],
              ),
              Divider(color: greyDivier),
              Row(
                children: [
                  Text(
                    'School Key',
                    style: TextStyle(
                        fontSize: 16,
                        color: mainAppBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${user.schoolKey}',
                    style: TextStyle(
                      fontSize: 16,
                      color: mainAppBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
