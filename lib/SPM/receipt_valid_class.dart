// To parse this JSON data, do
//
//     final receipIDreportValid = receipIDreportValidFromJson(jsonString);

import 'dart:convert';



class ReceipIDreportValid {
  ReceipIDreportValid({
    required this.receipt,
  });

  Receipt receipt;

  factory ReceipIDreportValid.fromJson(Map<String, dynamic> json) => ReceipIDreportValid(
    receipt: Receipt.fromJson(json["receipt"]),
  );

  Map<String, dynamic> toJson() => {
    "receipt": receipt.toJson(),
  };
}

class Receipt {
  Receipt({
    required this.accountBalance,
    required this.membershipId,
    required this.moneyPaid,
    required this.paymentDate,
    required this.receiptId,
    required this.validUntil,
  });

  int accountBalance;
  String membershipId;
  int moneyPaid;
  String paymentDate;
  String receiptId;
  String validUntil;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    accountBalance: json["accountBalance"],
    membershipId: json["membershipID"],
    moneyPaid: json["moneyPaid"],
    paymentDate: json["paymentDate"],
    receiptId: json["receiptID"],
    validUntil: json["validUntil"],
  );

  Map<String, dynamic> toJson() => {
    "accountBalance": accountBalance,
    "membershipID": membershipId,
    "moneyPaid": moneyPaid,
    "paymentDate": paymentDate,
    "receiptID": receiptId,
    "validUntil": validUntil,
  };
}
