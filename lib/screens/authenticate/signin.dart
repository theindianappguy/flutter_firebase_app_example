import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_example/services/auth.dart';
import 'package:flutter_firebase_app_example/shared/constants.dart';
import 'package:flutter_firebase_app_example/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //test feild state
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew',
        style: TextStyle(
          color: Colors.white
        ),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.length < 6 ? 'Enter Email': null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                    // obscure is for password
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Sign in',style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {

                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInEmailAndPass(email, password);
                        if(result == null){
                          setState(() {
                            error = "please supply a valid email";
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      }

                    },
                  ),
                  SizedBox(height: 20),
                  Text(error,
                    style: TextStyle( color: Colors.red, fontSize:  14.0123),)
                ],

              ),
            ),

            RaisedButton(
              child: Text('Sign in Anonymus'),
              onPressed: () async {
                dynamic result  = await _auth.signInAnom();
                if(result == null){
                  print('Error sign in');
                }else{
                  print('Sign in');
                  print(result.uid);
                }
                //result!=null?
              },
            ),
          ],
        )
      ),
    );
  }
}
