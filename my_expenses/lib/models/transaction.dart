import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
  });

  Transaction.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        amount = double.parse(map["amount"]),
        date = map["date"] is String
            ? DateTime.parse(map["date"])
            : map["date"];

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "amount": this.amount.toString(),
      "date": this.date.toString(),
    };
  }

}