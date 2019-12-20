import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_example/services/auth.dart';
import 'package:flutter_firebase_app_example/shared/constants.dart';
import 'package:flutter_firebase_app_example/shared/loading.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //test feild state
  String email = "";
  String password = "";
  bool loading = false;

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Registertiwarij to Brew Crew',
          style: TextStyle(
              color: Colors.white
          ),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
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
                      validator: (val) => val.isEmpty ? 'Enter an email': null,
                      onChanged: (val){
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      //validating
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
                      child: Text('Register',style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {

                       if(_formKey.currentState.validate()){
                         setState(() {
                           loading = true;
                         });
                         dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                         if(result == null){
                           setState(() {
                             error = "please supply a valid email";
                             loading = false;
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
            ],
          )
      ),
    );
  }
}
