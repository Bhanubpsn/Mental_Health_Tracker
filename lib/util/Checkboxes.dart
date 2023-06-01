import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ui/notification_service.dart';

class CheckboxExample extends StatefulWidget {
  bool isChecked;
  String id;
  String meal;
  CheckboxExample(this.isChecked,this.id,this.meal);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
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
      return Colors.green.withOpacity(0.5);
    }


      return Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: widget.isChecked,
        onChanged: (bool? value) {
          NotificationService().initializeNotification();
          setState(() {
              widget.isChecked = value!;
              db.collection('MentalHealth').doc(widget.id).update({widget.meal : value!});
              if(!value && widget.meal == 'Breakfast'){
                print("breakfast");
                NotificationService().showNotificationBreakfast(0, 'Reminder!', 'Have Breakfast');
              }
              if(!value && widget.meal == 'Lunch'){
                print("lunch");
                NotificationService().showNotificationBreakfast(1, 'Reminder!', 'Have Lunch');
              }
              if(!value && widget.meal == 'Dinner'){
                print("Dinner");
                // NotificationService().showNotificationWater(4, 'Testing', 'Testing');
                NotificationService().showNotificationBreakfast(2, 'Reminder!', 'Have Dinner');
              }
          });
        },
      );
  }
}

