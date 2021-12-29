import 'package:flutter/cupertino.dart';
import 'package:yt/Data/Handlers/UserHandler.dart';
import 'package:yt/Domain/Models/Recipe.dart';
import 'package:yt/Domain/Models/User.dart';

class CartProvider extends ChangeNotifier {
  AppUser user;
  bool check = true;
  int total = 0;
  CartProvider(this.user);
  List<Recipe> recipes = [];
  Map<String, Map<String, dynamic>> _buffer = {};
  Future<void> getCart() async {
    this._buffer = Map.castFrom<String, dynamic, String, Map<String, dynamic>>(await UserHandler(user).getCart());
    this.check = false;
    notifyListeners();
    this._buffer.forEach((key, value) => this.recipes.add(Recipe.forCart(key, value["Image"], value["Calores"], null, value["Grams"], value["Price"], value["Amount"])));
    _countTotal();
  }

  Future<void> _upDateDatabase(String title, [int amount = 0]) async {
    if (amount != 0) {
      this._buffer[title]["Amount"] = amount;
      await UserHandler(user).upDate(this._buffer);
    } else {
      this._buffer.remove(title);
      await UserHandler(user).newCart(this._buffer);
    }
  }

  _countTotal() {
    this.total = 0;
    this.recipes.forEach((element) => this.total += element.price * element.amount);
    notifyListeners();
  }

  increaseAmount(int index) {
    _upDateDatabase(this.recipes[index].title, ++this.recipes[index].amount);
    this.total += this.recipes[index].price;
    notifyListeners();
  }

  decreaseAmount(int index) {
    this.total -= this.recipes[index].price;
    (this.recipes[index].amount > 1) ? _upDateDatabase(this.recipes[index].title, --this.recipes[index].amount) : _upDateDatabase(this.recipes[index].title);
    if (this.recipes[index].amount <= 1) this.recipes.removeAt(index);
    notifyListeners();
  }

  removeRecipe(int index) {
    this.total -= this.recipes[index].price * this.recipes[index].amount;
    _upDateDatabase(this.recipes[index].title);
    this.recipes.removeAt(index);
    notifyListeners();
  }

  Future<void> order() async {}
}
