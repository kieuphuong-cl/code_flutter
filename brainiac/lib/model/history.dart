import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class History {
  String? id;
  String? fullname;
  String? dateCreated;
  int? total;
  History({
    this.id,
    this.fullname,
    this.dateCreated,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'dateCreated': dateCreated,
      'total': total,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'] != null ? map['id'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      dateCreated:
          map['dateCreated'] != null ? map['dateCreated'] as String : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source) as Map<String, dynamic>);
}
