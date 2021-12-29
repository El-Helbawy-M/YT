import 'package:flutter/material.dart';

class LogField extends StatelessWidget {
  LogField(this.fieldName, this.onChange, this.keyboardType, {this.validation});
  final String fieldName;
  final Function(String) onChange, validation;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1, color: Colors.green)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1, color: Colors.grey)),
          hintText: fieldName,
        ),
        obscureText: fieldName == "Password" ? true : false,
        onChanged: onChange,
        validator: validation,
        keyboardType: keyboardType,
      ),
    );
  }
}
