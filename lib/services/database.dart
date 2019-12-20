import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app_example/models/brew.dart';
import 'package:flutter_firebase_app_example/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  //
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strenght': strength,
    });
  }

  // brew List from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strenght: doc.data['strenght'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  //user data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot){
    return UserData(
      uid: uid,
      name: documentSnapshot.data['name'],
      strenght: documentSnapshot.data['strenght'],
      sugars: documentSnapshot.data['sugars'],
    );
  }

// get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
