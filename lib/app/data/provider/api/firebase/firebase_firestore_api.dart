import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseFirestoreAPI {
  static final CollectionReference _collectionUser =
      Firestore.instance.collection("users");
      

  Future<FirebaseUser> getUser(String uid) async {
    try {
      var doc = await _collectionUser.document(uid).get();
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
    await _collectionUser.document(idUser).setData(data, merge: true);
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
        .getDocuments();
    return snap.documents.length != 0;
  }

  updateUser(String idUser, Map<String, dynamic> data) async {
    await _collectionUser.document(idUser).setData(data, merge: true); 
  }

  setTokenNotifUser(String idUser, String token) async {
    var data = {
      'pushToken': token
    };
    await _collectionUser.document(idUser).updateData(data);
  }

}
