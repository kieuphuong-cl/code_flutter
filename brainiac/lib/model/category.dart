import '/page/auth/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CategoryModel {
  int? id;
  final String name;
  final String desc;
  final String? imageUrl;

  CategoryModel(
      {this.id, required this.name, required this.desc, this.imageUrl});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'desc': desc, 'imageUrl': imageUrl};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map["id"]?.toInt() ?? 0,
        name: map["name"] ?? '',
        desc: map["description"] ?? '',
        imageUrl: map["imageURL"] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Category(id: $id, name: $name, desc: $desc, imageUrl: $imageUrl)';
}
