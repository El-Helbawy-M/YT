import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Layout/Tools/Providers/AutherProvider.dart';
import 'package:yt/Layout/Widgets/LogButton.dart';
import 'package:yt/Layout/Widgets/LogField.dart';
import 'package:yt/System/Constants.dart';

class RegisterScreen extends StatelessWidget with Vaidation {
  RegisterScreen({Key key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    AspectRatio(aspectRatio: 1, child: Image.asset("Icons/Log/Icon_nut.png")),
                    Consumer<AutherProvider>(builder: (context, listner, child) => LogField("Name", listner.setName, TextInputType.text)),
                    Consumer<AutherProvider>(builder: (context, listner, child) => LogField("Phone Number", listner.setPhone, TextInputType.phone)),
                    Consumer<AutherProvider>(
                        builder: (context, listner, child) => LogField(
                              "Email",
                              listner.setEmail,
                              TextInputType.emailAddress,
                              validation: checkEmail,
                            )),
                    Consumer<AutherProvider>(
                        builder: (context, listner, child) => LogField(
                              "Password",
                              listner.setPassword,
                              TextInputType.visiblePassword,
                              validation: checkPassword,
                            )),
                    LogButton("Register", () async {
                      if (_formKey.currentState.validate()) await listner.load(context, true);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("You have an account ? "),
                          TextButton(onPressed: () => Navigator.pushReplacementNamed(context, "Sign In"), child: Text("Sign in Now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w900))),
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
