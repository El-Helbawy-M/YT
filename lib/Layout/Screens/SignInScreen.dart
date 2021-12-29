import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Layout/Tools/Providers/AutherProvider.dart';
import 'package:yt/Layout/Widgets/LogButton.dart';
import 'package:yt/Layout/Widgets/LogField.dart';
import 'package:yt/System/Constants.dart';

class SignInScreen extends StatelessWidget with Vaidation {
  SignInScreen({Key key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final listner = Provider.of<AutherProvider>(context);
    return Scaffold(
      body: (listner.loading)
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(aspectRatio: 1, child: Image.asset("Icons/Log/Icon_Red onion.png")),
                    Consumer<AutherProvider>(builder: (context, listner, child) => LogField("Email", listner.setEmail, TextInputType.emailAddress, validation: checkEmail)),
                    Consumer<AutherProvider>(builder: (context, listner, child) => LogField("Password", listner.setPassword, TextInputType.visiblePassword, validation: checkPassword)),
                    LogButton("Sign In", () async {
                      if (_formKey.currentState.validate()) listner.load(context, false);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("You don't have an account ? "),
                          TextButton(onPressed: () => Navigator.pushReplacementNamed(context, "Register"), child: Text("Register Now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w900))),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
