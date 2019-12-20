import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app_example/models/user.dart';
import 'package:flutter_firebase_app_example/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a use obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {

    return user != null ? User(uid: user.uid) : null;

  }

  // auth change user stram
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);

  }

  // sign in anom
  Future signInAnom() async {
    try {
      //make sure to enable it in firebase website
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password

  Future signInEmailAndPass(String email, String password) async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }

  }

// register with email and password

  Future registerWithEmailAndPassword(String email, String password) async{

    try{
      // registering user..
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;

      // create a new document for th user with the uid
      await DatabaseService(uid: firebaseUser.uid).updateUserData('0', 'Sanskar', 100);
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

// sign out, using future because it is an asyn task taskes some time to complete
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e);
    }
  }

}