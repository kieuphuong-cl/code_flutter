// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;
  String? catName;

  Product(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.des,
      this.catId,
      this.catName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'imageURL': img,
      'description': des,
      'categoryID': catId,
      'categoryName': catName
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      img: map['imageURL'] != null ? map['imageURL'] as String : null,
      des: map['description'] != null ? map['description'] as String : null,
      catId: map['categoryID'] != null ? map['categoryID'] as int : null,
      catName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
