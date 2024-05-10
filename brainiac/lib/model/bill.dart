import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bill {
  int? proID;
  int? count;

  Bill({
    this.proID,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': proID,
      'count': count,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      proID: map['productID'] != null ? map['productID'] as int : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}
