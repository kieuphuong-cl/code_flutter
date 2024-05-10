import 'dart:convert';
import 'dart:ffi';

import 'package:buoi_cuoi/model/category.dart';
import 'package:buoi_cuoi/model/history.dart';
import 'package:buoi_cuoi/model/product.dart';

import '../model/bill.dart';
import '/model/register.dart';
import '/model/user.dart';
import 'package:dio/dio.dart';

import 'sharepre.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> updateProfile(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }


  Future<String> login(String accountID, String password) async {
    try {
      final body =
          FormData.fromMap({'AccountID': accountID, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data['data']['token'];
        print("ok login");
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  // Future<String> changePassword(
  //     String accountID, String password, String newpass) async {
  //   try {
  //     final body =
  //         FormData.fromMap({'OldPassword': password, 'NewPassword': newpass});
  //     Response res = await api.sendRequest.put('/Auth/ChangePassword',
  //         options: Options(headers: header(await login(accountID, password))),
  //         data: body);
  //     if (res.statusCode == 200) {
  //       print("Changed Successfully");
  //       return "Change Successfully";
  //     } else {
  //       print("Failed Changed");
  //       return "Change Failed";
  //     }
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }

  Future<String> forgotPass(
      String accountID, String numberID, String newpass) async {
    try {
      final body =
          FormData.fromMap({'NumberID': numberID, 'NewPassword': newpass});
      Response res = await api.sendRequest.put('/Auth/forgetPass',
          options: Options(headers: header(await login(accountID, numberID))),
          data: body);
      if (res.statusCode == 200) {
        print("Changed Successfully");
        return "Change Successfully";
      } else {
        print("Failed Changed");
        return "Change Failed";
      }
    } catch (ex) {
      rethrow;
    }
  }


  Future<List<CategoryModel>> getCategoryList() async {
    try {
      final body = FormData.fromMap({'AccountID': await getaccountID()});
      Response res = await api.sendRequest.get(
          '/Category/getList?accountID=${await getaccountID()}',
          options: Options(headers: header(await getToken())),
          data: body);
      if (res.statusCode == 200) {
        print('load Cate successful');
      } else {
        print('load Cate fail');
      }
      return (res.data as List).map((e) => CategoryModel.fromMap(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> addCategory(CategoryModel cate) async {
    try {
      final body = FormData.fromMap({
        'Name': cate.name,
        'Description': cate.desc,
        'ImageURL': cate.imageUrl,
        'AccountID': await getaccountID()
      });
      Response res = await api.sendRequest.post('/addCategory',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Add Category Successfully');
        return 'Add Category Successfully';
      } else {
        print('Add Category Failed');
        return 'Add Category Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> updateCategory(CategoryModel cate) async {
    try {
      final body = FormData.fromMap({
        'id': cate.id,
        'Name': cate.name,
        'Description': cate.desc,
        'ImageURL': cate.imageUrl,
        'AccountID': await getaccountID()
      });
      Response res = await api.sendRequest.put('/updateCategory',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Update Category Successfully');
        return 'Update Category Successfully';
      } else {
        print('Update Category Failed');
        return 'Update Category Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> deleteCategory(int categoryID) async {
    try {
      final body = FormData.fromMap(
          {'categoryID': categoryID, 'accountID': await getaccountID()});
      Response res = await api.sendRequest.delete('/removeCategory',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Remove Category Successfully');
        return 'Remove Category Successfully';
      } else {
        print('Remove Category Failed');
        return 'Remove Category Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Product>> getProductList() async {
    try {
      final body = FormData.fromMap({'AccountID': await getaccountID()});
      Response res = await api.sendRequest.get(
          '/Product/getList?accountID=${await getaccountID()}',
          options: Options(headers: header(await getToken())),
          data: body);
      if (res.statusCode == 200) {
        print('load Products successful');
      } else {
        print('load Products fail');
      }
      return (res.data as List).map((e) => Product.fromMap(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Product>> getProductListByID(int cateID) async {
    try {
      final body = FormData.fromMap(
          {'categoryID': cateID, 'accountID': await getaccountID()});
      Response res = await api.sendRequest.get(
          '/Product/getListByCatId?categoryID=$cateID&accountID=${await getaccountID()}',
          options: Options(headers: header(await getToken())),
          data: body);
      if (res.statusCode == 200) {
        print('load Products by CateID successful');
      } else {
        print('load Products by CateID fail');
      }
      return (res.data as List).map((e) => Product.fromMap(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> addProduct(Product pro) async {
    try {
      final body = FormData.fromMap({
        'Name': pro.name,
        'Description': pro.des,
        'ImageURL': pro.img,
        'Price': pro.price,
        'CategoryID': pro.catId
      });
      Response res = await api.sendRequest.post('/addProduct',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Add Product Successfully');
        return 'Add Product Successfully';
      } else {
        print('Add Product Failed');
        return 'Add Product Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> updateProduct(Product pro) async {
    try {
      final body = FormData.fromMap({
        'id': pro.id,
        'Name': pro.name,
        'Description': pro.des,
        'ImageURL': pro.img,
        'Price': pro.price,
        'CategoryID': pro.catId,
        'accountID': await getaccountID()
      });
      Response res = await api.sendRequest.put('/updateProduct',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Update Product Successfully');
        return 'Update Product Successfully';
      } else {
        print('Update Product Failed');
        return 'Update Product Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> deleteProduct(int productID) async {
    try {
      final body = FormData.fromMap(
          {'productID': productID, 'accountID': await getaccountID()});
      Response res = await api.sendRequest.delete('/removeProduct',
          options: Options(headers: header(await getToken())), data: body);
      if (res.statusCode == 200) {
        print('Remove Product Successfully');
        return 'Remove Product Successfully';
      } else {
        print('Remove Product Failed');
        return 'Remove Product Failed';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<History>> getHistory() async {
    try {
      Response res = await api.sendRequest.get('/Bill/getHistory',
          options: Options(headers: header(await getToken())));
      if (res.statusCode == 200) {
        print('Get History Successfully');
      } else {
        print('Get History Failed');
      }
      return (res.data as List).map((e) => History.fromMap(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> toBill(List<Bill> bill) async {
    try {
      var json = jsonEncode(bill.map((e) => e.toMap()).toList());
      Response res = await api.sendRequest.post('/Order/addBill',
          options: Options(headers: header(await getToken())), data: json);
      if (res.statusCode == 200) {
        print('Created Bill Successfully');
      } else {
        print('Created Bill Failed');
      }
    } catch (ex) {
      rethrow;
    }

    return "";
  }
}
