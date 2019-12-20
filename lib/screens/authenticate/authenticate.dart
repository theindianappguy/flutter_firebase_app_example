import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_example/screens/authenticate/register.dart';
import 'package:flutter_firebase_app_example/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool _showSignIn = true;

  void toggleView(){
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSignIn ? SignIn(toggleView: toggleView):Register(toggleView: toggleView);
  }
}
