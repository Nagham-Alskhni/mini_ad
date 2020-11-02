import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniad/screens/CreatProduct.dart';
import 'package:miniad/screens/FirstPage.dart';
import 'package:miniad/screens/PhoneLogIn.dart';
import 'package:miniad/screens/userProfile.dart';
import 'moudels/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/productspage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}
