import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';


class FireAuth {
  // register user using firebase_auth and then save user data to firestore(fullname, email, phone
  static Future<User?> registerUsingEmailPassword({required String fullname,
    required String email,
    required String password,
    required String phone,
    required BuildContext context}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      UserCredential _userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user data to firestore
      await _firestore.collection('users').doc(_userCredential.user!.uid).set({
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'createdAt': Timestamp.now(),
      });

      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      }
      else if (e.code == 'invalid-email') {
        showSnackBar(context, 'The email address is not valid.');
      } else if(e.code == 'phone-number-already-exists') {
        showSnackBar(context, 'The phone number already exists.');
      }else {
        showSnackBar(context, e.toString());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return null;
  }


  // login user using firebase_auth
static Future<User?> loginUsingEmailPassword({required String email,
  required String password,
  required BuildContext context}) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    UserCredential _userCredential =
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _userCredential.user;
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'user-not-found') {
      showSnackBar(context, 'No user found for that email.');
    } else if (e.code == 'envalid-password') {
      showSnackBar(context, 'Wrong password provided for that user.');
    }
    else if (e.code == 'invalid-email') {
      showSnackBar(context, 'The email address is not valid.');
    }
    else {
      showSnackBar(context, e.toString());
      throw e;
    }

  } catch (e) {
    showSnackBar(context, e.hashCode.toString());
    throw e;
  }
  return null;
}

  // reset password using firebase_auth

  static Future<void> resetPassword({required String email,
    required BuildContext context}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      showSnackBar(context, 'Reset password link has sent to your email');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      }
      else if (e.code == 'invalid-email') {
        showSnackBar(context, 'The email address is not valid.');
      }
      else {
        showSnackBar(context, e.toString());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign out using firebase_auth

  static Future<void> signOut({required BuildContext context}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      // check if user is signed in or not
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }
      else {
        showSnackBar(context, 'No user signed in');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}