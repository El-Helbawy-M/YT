import 'package:flutter/material.dart';

Color color = Colors.blue.shade100;
//==================================== Font Styles
const kTextTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
const kTextCategoryNameStyle = TextStyle(fontSize: 18);
//====================================
//==================================== Enum Classes
enum RequestState { OK, WeakPassword, AlreadyInUse, Unknown, NotFound, WrongPassword }
enum Operation { NEW, UPDATE }
enum CardType { Visa, MasterCard, Discover }
//====================================
//==================================== Maps
Map<RequestState, String> alertMasseges = {
  RequestState.OK: "Succeeded",
  RequestState.Unknown: "Something wrong\nPlease try again",
  RequestState.NotFound: "Email is not found",
  RequestState.AlreadyInUse: "Email is already in use",
  RequestState.WeakPassword: "This is a week password",
  RequestState.WrongPassword: "Wrong password",
};
//====================================
//==================================== Mixin
mixin Vaidation {
  String checkEmail(String value) => (value.contains("@") && value.contains(".com")) ? null : "Wrong email !";
  String checkPassword(String value) => (value.length > 5) ? null : "The password must be greater than 5 chracter";
}
//====================================
//====================================
List<String> categoriesList = ["Burger", "Fries", "Tacos", "Salad", "Pizza", "Juice"];

bool check1 = false, check2 = false, check3 = false;

const TextStyle kRecipeTextStye = TextStyle(
  fontSize: 25,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
TextStyle kPaymentTextStyle = kRecipeTextStye.copyWith(fontSize: 25);

List<Map<String, dynamic>> items = [];

OutlineInputBorder focusBroder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 3,
    color: Colors.green,
  ),
  borderRadius: BorderRadius.circular(10),
);

OutlineInputBorder enabledBorder = focusBroder.copyWith(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

InputDecoration kTextFieldStyle({String hint, label, IconData icon}) => InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.green,
      ),
      focusedBorder: focusBroder,
      enabledBorder: enabledBorder,
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.green,
      ),
    );
