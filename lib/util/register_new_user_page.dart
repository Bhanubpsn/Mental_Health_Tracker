import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../ui/Homepage.dart';

class NewUserRegister extends StatelessWidget {

  String photoUrl;
  String name;
  String id;

  NewUserRegister(this.photoUrl,this.name,this.id);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Registering ${name}",
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
              ),
              SizedBox(height: 15,),
              CircularProgressIndicator(),
            ],
          ),
          nextScreen: homepage(photoUrl,name,id)
      ),
    );
  }
}