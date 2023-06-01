import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mental_health_tracker/model/sign_in_page.dart';
import 'package:mental_health_tracker/ui/todo.dart';
import 'package:mental_health_tracker/util/checkbox_water.dart';
import '../util/Checkboxes.dart';
import 'Breathe.dart';
import 'notification_service.dart';

class homepage extends StatefulWidget {
  String photoUrl;
  String name;
  String id;

  homepage(this.photoUrl,this.name,this.id);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final db = FirebaseFirestore.instance;
  void tempFunc() async{
    var docSnapshot = await db.collection('MentalHealth').doc(widget.id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    // var ppl = data?['People_Talked_to'];
    WidgetsFlutterBinding.ensureInitialized();
    NotificationService().initializeNotification();
    NotificationService().showNotificationPeople(3, 'People Talked To --',data?['People_Talked_to']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempFunc();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: db.collection('MentalHealth').doc(widget.id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("");
          }
          var userDetails = snapshot.data;

          return Scaffold(
            body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hi,\n${widget.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                            color: Colors.lightGreen.shade800,
                          ),
                        ),
                        SizedBox(width: 25,),
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius
                                .circular(50.0)),
                            image: DecorationImage(image: NetworkImage(
                                widget.photoUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Icon(Icons.lock_open, size: 40,),
                              onTap: () {
                                logout();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                              },
                            ),
                            Text("LogOut?"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Look Perfect :)",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      // SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 120.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Get Hourly Water reminder",
                                style: TextStyle(
                                  color: Colors.blue.shade400,
                                  fontWeight: FontWeight.w600
                                ),

                            ),
                            SizedBox(width: 5,),
                            Icon(Icons.water_drop,size: 20,color: Colors.blue,),
                            CheckboxWater(userDetails?['Reminder_Water'], widget.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 8,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "How Many People did you\ntalk to today?",
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Slider(
                          max: 10,
                          min: 0,
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: userDetails?['People_Talked_to'].toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              db.collection('MentalHealth').doc(widget.id).update({"People_Talked_to" : value.round()});
                            });
                          },
                        ),
                        Text(
                          userDetails!['People_Talked_to'].toString(),
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 8,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See Your\nTO-DO List",
                              style: TextStyle(
                                  color: Colors.green.withOpacity(0.6),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 15,),
                            InkWell(
                              child: Icon(
                                Icons.calendar_month_outlined, color: Colors
                                  .green.withOpacity(0.6), size: 70,),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TODO(widget.id)));
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 8,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Did you eat?",
                              style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Row(
                              children: [
                                CheckboxExample(userDetails?['Breakfast'],widget.id,'Breakfast'),
                                Text(
                                  "Breakfast",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CheckboxExample(userDetails?['Lunch'],widget.id,'Lunch'),
                                Text(
                                  "Lunch",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CheckboxExample(userDetails?['Dinner'],widget.id,'Dinner'),
                                Text(
                                  "Dinner",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 8,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Feeling Anxious?\nDon't Worry\nLet's Breathe",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w800,
                              fontSize: 20
                          ),
                        ),
                        SizedBox(width: 50,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  image: DecorationImage(
                                    image: AssetImage("images/icon-512.png",),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => breathe()));
                              },
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Click Me!",
                              style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]
            ),
          );
        }
    );
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }


  
  
  
}
