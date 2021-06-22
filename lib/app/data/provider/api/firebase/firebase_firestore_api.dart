import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseFirestoreAPI {
  static final CollectionReference _collectionUser =
      FirebaseFirestore.instance.collection("users");
      

  Future<User> getUser(String uid) async {
    try {
      var doc = await _collectionUser.doc(uid).get();
      if (doc.data != null) {
       // return User.fromDocument(doc);
      }
      return null;
    } catch (err) {
      print("ERROR: Firebase Firestore API: GetUser() - $err");
      return null;
    }
  }

  initUser(String idUser, String phoneNumber, String email) async {
    var data = {
      'userId': idUser,
      'phoneNumber': phoneNumber,
      'email': email,
      'createAt': FieldValue.serverTimestamp()
    };
    await _collectionUser.doc(idUser).set(data, SetOptions(merge: true));
    data.remove("createAt");
    data.addAll({
      "Pictures": {"pictures": []},
      "age_range": {"min": 18, "max": 23},
      "editInfo": {"domain": "domain"}
    });
  }

  Future<bool> isEmailExist(String email) async {
    var snap = await _collectionUser
        .where("email", isEqualTo: email)
        .limit(1)
        .get();
    return snap.docs.length != 0;
  }

  updateUser(String idUser, Map<String, dynamic> data) async {
    await _collectionUser.doc(idUser).set(data, SetOptions(merge: true)); 
  }

  setTokenNotifUser(String idUser, String token) async {
    var data = {
      'pushToken': token
    };
    await _collectionUser.doc(idUser).update(data);
  }

}
