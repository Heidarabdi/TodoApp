

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ProfileActions {
  late BuildContext context;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileActions({required this.context});


  // update user data only one field
  Future<void> updateUserData(String field, String value) async {
    try{
    var user = FirebaseAuth.instance.currentUser;
    print(
        "user id is ${user!.uid} and field is $field and value is $value"
    );
    if (field == 'email') {
      await user!.updateEmail(value);
      await _firestore.collection('users').doc(user.uid).update({
        field: value,
      }).then((value) {
        showSnackBar(context, "Updated Successfully");
      }).catchError((error) {
        showSnackBar(context, error.toString());
      });
    } else {
      await _firestore.collection('users').doc(user!.uid).update({
        field: value,
      }).then((value) {
        showSnackBar(context, "Updated Successfully");
      }).catchError((error) {
        showSnackBar(context, error.toString());
      });
    }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  // update password from firebase auth
  Future<void> updatePassword(String newPassword, String oldPassword) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: oldPassword
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      showSnackBar(context, "Password Updated Successfully");
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  // delete user from firebase auth and firestore
  Future<void> deleteUser() async {
    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    try {
      var user = FirebaseAuth.instance.currentUser;
      // path profile/${user!.uid}
      await _firebaseStorage.ref().child('profile').child(user!.uid).delete();
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}

