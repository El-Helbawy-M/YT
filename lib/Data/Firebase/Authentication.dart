import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt/Data/Handlers/UserHandler.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/System/Constants.dart';

class Auther {
  String _password;
  AppUser _user;
  FirebaseAuth _auther = FirebaseAuth.instance;
  Auther(this._user, this._password);

  Future<RequestState> sighIn() async {
    try {
      await _auther.signInWithEmailAndPassword(email: this._user.email, password: this._password);
      return RequestState.OK;
    } on FirebaseAuthException catch (e) {
      return (e.code == 'user-not-found') ? RequestState.NotFound : RequestState.WrongPassword;
    } catch (e) {
      return RequestState.Unknown;
    }
  }

  Future<RequestState> register() async {
    try {
      await _auther.createUserWithEmailAndPassword(email: this._user.email, password: this._password);
      await UserHandler(this._user).newUser().then((value) => UserHandler(this._user).newCart({}));
      return RequestState.OK;
    } on FirebaseAuthException catch (e) {
      return (e.code == 'weak-password') ? RequestState.WeakPassword : RequestState.AlreadyInUse;
    } catch (e) {
      return RequestState.Unknown;
    }
  }
}

//Auther(user,passwor).register();