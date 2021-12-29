import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Layout/Screens/RegisterScreen.dart';
import 'package:yt/Layout/Screens/SignInScreen.dart';
import 'package:yt/Layout/Tools/Providers/AutherProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Sign In",
      routes: {"Register": (context) => ChangeNotifierProvider(create: (BuildContext context) => AutherProvider(), child: RegisterScreen()), "Sign In": (context) => ChangeNotifierProvider(create: (BuildContext context) => AutherProvider(), child: SignInScreen())},
    );
  }
}
