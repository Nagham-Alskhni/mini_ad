import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class FirstTry {
//  String smsCode;
//  FirebaseAuth auth = FirebaseAuth.instance;
//
//  Future submit() async {
//    final PhoneVerificationCompleted verificationDone =
//        (AuthCredential credential) {}; // if the auth success
//    final PhoneVerificationFailed verificationFailed =
//        (FirebaseAuthException firebaseException) {
//      print("${firebaseException.message}"); // if the auth faild
//    };
//    Future<bool> smsCodeDialog(BuildContext context) {
//      return showDialog(
//          context: context,
//          barrierDismissible: false,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              title: Text(
//                'please Enter Your Code',
//                style: TextStyle(color: Colors.blue),
//              ),
//              content: TextField(
//                onChanged: (value) {
//                  smsCode = value;
//                },
//              ),
//              contentPadding: EdgeInsets.all(10),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('Verfiy'),
//                  onPressed: () {},
//                )
//              ],
//            );
//          });
//    }
//
//    final PhoneCodeSent phonecodesent = (String verId, [int codeResend]) {
//      verificationCode = verId;
//      smsCodeDialog(context).then((value) => print('done'));
//    };
//    await auth.verifyPhoneNumber(
//      phoneNumber: users.phoneNumber,
//      verificationCompleted: verificationDone,
//      verificationFailed: verificationFailed,
//      codeSent: phonecodesent,
//      codeAutoRetrievalTimeout: null,
//    );
//  }
//}
