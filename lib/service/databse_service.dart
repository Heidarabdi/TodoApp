

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
  Future<bool> updateUserData(String field, String value) async {
    try{
    var user = FirebaseAuth.instance.currentUser;
    if (field == 'email') {
      await user!.updateEmail(value);
      await _firestore.collection('users').doc(user.uid).update({
        field: value,
      }).then((value) {
        showSnackBar(context, "Updated Successfully");
      }).catchError((error) {
        showSnackBar(context, error.toString());
      });
      return true;
    } else {
      await _firestore.collection('users').doc(user!.uid).update({
        field: value,
      }).then((value) {
        showSnackBar(context, "Updated Successfully");
      }).catchError((error) {
        showSnackBar(context, error.toString());
      });
      return true;
    }
    } catch (error) {
      showSnackBar(context, error.toString());
      return false;
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

class TaskActions{
  late BuildContext context;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TaskActions({required this.context});

  // add task to firestore
  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await _firestore.collection('users').doc(user!.uid).collection('tasks').add(task); // add task to firestore collection tasks under user id collection users named tasks
      showSnackBar(context, "Task Added Successfully");
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  // update task from firestore
  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await _firestore.collection('users').doc(user!.uid).collection('tasks').doc(id).update(task);
      showSnackBar(context, "Task Updated Successfully");
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  // delete task from firestore
  Future<void> deleteTask(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await _firestore.collection('users').doc(user!.uid).collection('tasks').doc(id).delete();
      showSnackBar(context, "Task Deleted Successfully");
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}

