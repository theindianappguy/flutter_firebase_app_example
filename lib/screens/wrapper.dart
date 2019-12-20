import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_example/models/user.dart';
import 'package:flutter_firebase_app_example/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_app_example/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    return user != null? Home():Authenticate();
  }
}
