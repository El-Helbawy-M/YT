import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Data/Firebase/Authentication.dart';
import 'package:yt/Data/Handlers/UserHandler.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/Layout/Screens/HomeScreen.dart';
import 'package:yt/Layout/Tools/Providers/DataProvider.dart';
import 'package:yt/Layout/Widgets/Dialogs.dart';
import 'package:yt/System/Constants.dart';

class AutherProvider extends ChangeNotifier {
  String name, email, password;
  int phone;
  bool loading = false;

  setName(String value) {
    this.name = value;
    notifyListeners();
  }

  setEmail(String value) {
    this.email = value;
    notifyListeners();
  }

  setPassword(String value) {
    this.password = value;
    notifyListeners();
  }

  setPhone(String number) {
    this.phone = int.parse(number);
    notifyListeners();
  }

  load(BuildContext context, bool check) async {
    this.loading = true;
    notifyListeners();
    AppUser user = AppUser(this.name, this.email, this.phone);
    RequestState state = (check) ? await Auther(user, this.password).register() : await Auther(user, this.password).sighIn();

    if (state == RequestState.OK) {
      if (check) {
        this.loading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => DataProvider(user, categoriesList[0], 1), child: HomeScreen())), (route) => false);
      } else {
        Map<String, dynamic> userData = await UserHandler(user).getUser();
        user = AppUser(userData["Name"], userData["Email"], userData["Phone"]);
        this.loading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => DataProvider(user, categoriesList[0], 1), child: HomeScreen())), (route) => false);
      }
    } else
      showDialog(context: context, builder: (context) => massage(state));
    this.loading = false;
    notifyListeners();
  }
}
