import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ui/notification_service.dart';

class CheckboxWater extends StatefulWidget {
  bool isChecked;
  String id;

  CheckboxWater(this.isChecked,this.id);

  @override
  State<CheckboxWater> createState() => _CheckboxWaterState();
}

class _CheckboxWaterState extends State<CheckboxWater> {
  final db = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }


    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: widget.isChecked,
      onChanged: (bool? value) {
        NotificationService().initializeNotification();
        setState(() {
          widget.isChecked = value!;
          db.collection('MentalHealth').doc(widget.id).update({'Reminder_Water' : value!});
          print(value);
          if(value){
            NotificationService().showNotificationWater(4, 'Reminder!', 'Drink Water');
          }
          else{
            NotificationService().stopReminder();
          }
        });



      },
    );
  }
}

