import 'package:flutter/material.dart';

SnackBar orderBar(String content) => new SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.done,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                content,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
    );
