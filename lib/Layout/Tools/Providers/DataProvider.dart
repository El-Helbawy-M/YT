import 'package:flutter/cupertino.dart';
import 'package:yt/Domain/Models/Recipe.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/Data/Handlers/UserHandler.dart';
import '../../../Data/Api/Sponaculur.dart';

class DataProvider with ChangeNotifier {
  DataProvider(this._user, this._recipe, this._counter) {
    this.handler = UserHandler(this._user);
  }

  // Varibales \
  UserHandler handler;
  AppUser _user;
  String _recipe;
  int _counter = 1, _index = 0, _total = 0, _orders = 0;
  List<Recipe> data = [];
  Map<String, int> orderedList = {};
  bool check = true;
  //==================================

  // Getters \
  AppUser get user => this._user;
  int get index => this._index;
  int get counter => this._counter;
  String get recipe => this._recipe;
  int get total => this._total;
  int get orders => this._orders;
  //==================================

  // Setters \
  set setrecipe(String recipe) {
    this._recipe = recipe;
    notifyListeners();
  }

  //==================================

  // Funcations \
  increase() {
    this._counter++;
    notifyListeners();
  }

  decrease() {
    if (this._counter > 1) {
      this._counter--;
      notifyListeners();
    }
  }

  addOrder(String order) {
    this._orders++;
    notifyListeners();
    (this.orderedList.containsKey(order)) ? this.orderedList[order] += this._counter : this.orderedList.addAll({order: this._counter});
    this._counter = 1;
  }

  Future<void> getData() async {
    if (this.data.isNotEmpty) {
      this.data = [];
      notifyListeners();
    }
    this.data = await Sponaculur().getData(recipe);
    notifyListeners();
  }

  Future<void> getOrderedList() async {
    this.orderedList = {};
    this._orders = 0;
    Map<String, dynamic> buffer = await this.handler.getCart();
    buffer.forEach((key, value) => this.orderedList.addAll({key: value["Amount"]}));
    if (this.orderedList == null)
      this.orderedList = {};
    else {
      this.orderedList.values.forEach((element) => this._orders += element);
    }
    this.check = false;
    notifyListeners();
  }
  //==================================

}
