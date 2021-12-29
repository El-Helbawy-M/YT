import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:yt/Data/Api/Checkout.dart';
import 'package:yt/Data/Handlers/UserHandler.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/Layout/Widgets/Dialogs.dart';
import 'package:yt/System/Constants.dart';

class CriditPaymentProvider extends ChangeNotifier {
  int year, month, number, amount;
  bool loading = false;
  AppUser _user;
  CardType cardType = CardType.Visa;
  CriditPaymentProvider(this._user, this.amount);
  setMonthAndYear(int month, int year) {
    this.month = month;
    this.year = year;
    notifyListeners();
  }

  set setNumber(String number) {
    this.number = int.parse(number);
    notifyListeners();
  }

  changeCardType(CardType type) {
    this.cardType = type;
    notifyListeners();
  }

  Future<void> pay(BuildContext context) async {
    loading = true;
    notifyListeners();
    CheckOut op = new CheckOut(CreditCard(number: "4242 4242 4242 4242", cvc: 314.toString(), expYear: this.year, expMonth: this.month, brand: "visa"));
    RequestState state = await op.pay(this.amount);
    if (state == RequestState.OK) await UserHandler(this._user).newCart({});
    loading = false;
    notifyListeners();
    showDialog(context: context, builder: (context) => (state == RequestState.OK) ? succeeded : failed).then((value) {
      if (state == RequestState.OK) for (int x = 0; x < 2; x++) Navigator.pop(context);
    });
  }
}
