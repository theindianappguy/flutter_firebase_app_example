import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_example/models/user.dart';
import 'package:flutter_firebase_app_example/services/database.dart';
import 'package:flutter_firebase_app_example/shared/constants.dart';
import 'package:flutter_firebase_app_example/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

   // this is provider
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(labelText: 'Name'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strenght).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strenght],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strenght],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.toInt()),
                  ),
                  //slider
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                     if(_formkey.currentState.validate()){
                       await DatabaseService(uid: user.uid).updateUserData(
                           _currentSugars ?? userData.sugars,
                           _currentName ?? userData.name,
                           _currentStrength ?? userData.strenght
                       );
                       Navigator.pop(context);
                     }
                    }
                  ),
                ],
              ),
            );
          } else {

            return Loading();
          }
        });
  }
}
