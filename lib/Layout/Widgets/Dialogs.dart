import 'package:flutter/material.dart';
import 'package:yt/System/Constants.dart';

AlertDialog succeeded = AlertDialog(
  title: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Succeded", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      SizedBox(width: 10),
      Icon(Icons.done, color: Colors.green, size: 40),
    ],
  ),
  content: Text(
    "Succeded",
    style: TextStyle(fontSize: 20),
  ),
);

AlertDialog failed = AlertDialog(
  title: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Error", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      SizedBox(width: 10),
      Icon(Icons.close, color: Colors.red, size: 40),
    ],
  ),
  content: Text(
    "Failed",
    style: TextStyle(fontSize: 20),
  ),
);

AlertDialog massage(RequestState state) => AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Warning", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Icon(Icons.error_outline, color: Colors.yellow, size: 40),
        ],
      ),
      content: Text(alertMasseges[state], style: TextStyle(fontSize: 20)),
    );
