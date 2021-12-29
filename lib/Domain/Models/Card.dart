// import 'package:flutter/material.dart';

class PaymentCard {
  int expiryMonth, expiryYear, cvv;
  String number;
  PaymentCard(this.number, this.cvv, this.expiryYear, this.expiryMonth);
  Map<String, dynamic> get cardDetails => {"number": this.number, "cvv": this.cvv, "expiry_month": this.expiryMonth, "expiry_year": this.expiryYear};
}
