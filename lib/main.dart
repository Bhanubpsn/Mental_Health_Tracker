import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'model/sign_in_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
   debugShowCheckedModeBanner: false,
   home: SignInPage(),
 ));
}



