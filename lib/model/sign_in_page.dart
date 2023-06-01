import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mental_health_tracker/ui/Homepage.dart';
import '../util/register_new_user_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);


  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final db = FirebaseFirestore.instance;

  Future getDocs() async{
    QuerySnapshot querySnapshot = await db.collection('MentalHealth').get();
    for(int i =0; i < querySnapshot.docs.length; i++){
      db.collection('MentalHealth').doc(querySnapshot.docs[i] as String?).update({
        'Breakfast' : false,
        'Lunch' : false,
        'Dinner' : false,
        'People_Talked_to' : 0
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currTime = DateTime.now();
    if(currTime == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,23,30,0)){
      getDocs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Text(
                      "Welcome! ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff22CB5C),
                      ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "images/IMG_20230528_110136.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  image:DecorationImage(
                    image: AssetImage("images/icon-512.png",),
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            const SizedBox(height: 40,),
            InkWell(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.7),
                  border: Border.all(color: Colors.black,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                        child: Image.asset(
                        "images/google.png",
                          fit: BoxFit.fitWidth,
                        ),
                    ),
                    const SizedBox(width: 8,),
                    Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18
                        ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                googleLogin();
              },
            ),
          ],
        ),
      ),
    );
  }


  late String photoUrl;
  late String name;
  late String id;

  //Checking if the id exists or not.
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = db.collection('MentalHealth');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }






  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var user = await _googleSignIn.signIn();
      if (user == null) {
        return;
      }


      final userData = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult = await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $user");
      print(user.displayName);
      print(user.email);
      print(user.photoUrl);
      setState(() {
        photoUrl = user.photoUrl!;
        id = user.id!;
        List<String> fullname = user.displayName!.split(" ");
        name = fullname[0];
        if(name.length > 5){
          name = name.substring(0,5)+"\n"+name.substring(5,name.length);
        }
        print(name);
      });

      bool docExists = await checkIfDocExists(user.id);
      print("${docExists}user");
      if(!docExists)
      {
        await db.collection('MentalHealth').doc(user.id).set({
          "name" : user.displayName,
          "email" : user.email,
          "photo" : user.photoUrl,
          "Breakfast" : false,
          "Lunch" : false,
          "Dinner" : false,
          "People_Talked_to" : 0,
          "Reminder_Water" : false,
          "tasks" : [],
          "Done" : [],
          "timestamp" : [],
        });
        print("LogIn success");

        Navigator.push(context, MaterialPageRoute(builder: (context) =>NewUserRegister(photoUrl,name,id)));
      }

      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>homepage(photoUrl,name,id)));
      }


    } catch (error) {
      print(error);
    }
  }






}
