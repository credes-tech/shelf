


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // context.push("/home/profile");
      },
      icon: Icon(Icons.account_circle_rounded),
      color: Colors.black,
      iconSize: 30,
    );
  }
}