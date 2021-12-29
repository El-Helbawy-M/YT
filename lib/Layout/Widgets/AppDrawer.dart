import 'package:flutter/material.dart';
import 'package:yt/Domain/Models/User.dart';

Drawer appDrawer(BuildContext context, AppUser user) => Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              color: Colors.green,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, image: DecorationImage(image: AssetImage("Icons/avatar (8).png"))),
                    width: 100,
                    height: 100,
                  ),
                  Text(user.name, style: TextStyle(fontSize: 25, fontFamily: "Modak", color: Colors.white)),
                  Text(user.email, style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              dense: true,
              title: Text("Sign out", style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, "Sign In", (route) => false),
            ),
            Divider(thickness: 2, height: 8)
          ],
        ),
      ),
    );
