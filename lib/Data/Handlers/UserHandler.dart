import 'package:yt/Data/Firebase/Firestore.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/System/Constants.dart';

class UserHandler extends Database {
  AppUser _user;
  UserHandler(this._user) : super("Users");
  Future<RequestState> newUser() async => await editDocument(this._user.email, this._user.personalData, Operation.NEW);
  Future<RequestState> updateUser() async => await editDocument(this._user.email, this._user.personalData, Operation.UPDATE);
  Future<Map<String, dynamic>> getUser() async => await getDocument(this._user.email);
  Future<RequestState> deleteUser() async => await deleteDocument(this._user.email);
  Future<RequestState> newCart(Map<String, Map<String, dynamic>> data) async => Database("Cart").editDocument(this._user.email, data, Operation.NEW);
  Future<RequestState> addRecipe(Map<String, Map<String, dynamic>> data) async => Database("Cart").editDocument(this._user.email, data, Operation.UPDATE);
  Future<Map<String, dynamic>> getCart() async => await Database("Cart").getDocument(this._user.email);
  Future<RequestState> upDate(Map<String, dynamic> data) async => await Database("Cart").editDocument(this._user.email, data, Operation.UPDATE);
}
