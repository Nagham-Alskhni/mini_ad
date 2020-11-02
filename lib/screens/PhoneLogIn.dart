import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniad/moudels/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniad/screens/FirstPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneLogIn extends StatefulWidget {
  @override
  _PhoneLogInState createState() => _PhoneLogInState();
}

class _PhoneLogInState extends State<PhoneLogIn> {
  Users usersModels;
  String userName;
  String verificationId;
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
//  void initState() {
//    super.initState();
//    Firebase.initializeApp().whenComplete(() {
//      print("completed");
//      setState(() {});
//    });
//  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    // what the below line do added by me after error null??????
    final PhoneCodeAutoRetrievalTimeout autoRetriv = (String verId) {
      verificationId = verId;
    };
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 40),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop(); // what this line do?
        //instade of auth result
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User user = userCredential.user;

        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        // Strig uId replaced with below
        String uId = _auth.currentUser.uid.toString();
        users.doc(uId).set(
            {'phoneNumer': _phoneController.text}, SetOptions(merge: true));
//        users.add({'uId': uId});

//        setupUser();

        if (user != null) {
          print('done');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FirstPage()));
        } else {
          print('error');
        }
      },
      verificationFailed: (FirebaseAuthException firebaseException) {
        print(firebaseException);
      },
      codeSent: (String verId, [int forceResend]) {
        // what is showDialog???
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('please write your code in the sms'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                    child: Text('Log In'),
                    onPressed: () async {
                      final code = _codeController.text.trim(); // what is trim
                      AuthCredential credential = PhoneAuthProvider.credential(
                        smsCode: code,
                        verificationId: verId,
                      );
                      UserCredential userCredential =
                          await _auth.signInWithCredential(credential);
                      User user = userCredential.user;
                      if (user != null) {
                        // need to write Navigator code

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()));
                      } else {
                        print('error');
                      }
                    },
                  ),
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: autoRetriv,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mini Ad'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity, // what this?
                    child: FlatButton(
                      child: Text('Log In'),
                      textColor: Colors.blue,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        setState(() {
                          final phoneEditController =
                              _phoneController.text.trim();
                          loginUser(phoneEditController, context);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
