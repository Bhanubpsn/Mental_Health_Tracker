import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TODO extends StatefulWidget {
  String id;

  TODO(this.id);

  @override
  State<TODO> createState() => _TODOState();
}

class _TODOState extends State<TODO> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green.shade600,
      ),
      home: MyApp(widget.id),
    );
  }
}

class MyApp extends StatefulWidget {
  String id;
  MyApp(this.id);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todos = [];
  List done = [];
  List dates = [];
  String input = "";
  final db = FirebaseFirestore.instance;
  bool checked = false;

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
      return Colors.green.shade100;
    }



    return StreamBuilder(
      stream: db.collection('MentalHealth').doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("");
        }
        var userDetails = snapshot.data;
        todos = userDetails?['tasks'];
        done = userDetails?['Done'];
        dates = userDetails?['timestamp'];


        return Scaffold(
          appBar: AppBar(
            title: Text("My TODOs"),
            backgroundColor: Colors.green.shade800,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            splashColor: Colors.blue,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Text("Add ToDoList"),
                      content: TextField(
                        onChanged: (String value) {
                          setState(() {
                            input = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Go for a Run',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                          )
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                todos.add(input);
                                done.add(false);
                                dates.add(DateTime.now().day.toString() +"/"+ DateTime.now().month.toString() +"/"+DateTime.now().year.toString()+" "+ DateTime.now().hour.toString() +":"+ DateTime
                                .now().minute.toString());
                                db.collection('MentalHealth').doc(widget.id).update({
                                  'tasks' : todos,
                                  'Done' : done,
                                  'timestamp' : dates,
                                });
                                input = "";
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                        )
                      ],

                    );
                  }
              );
            },
            child: Icon(Icons.add, color: Colors.green.shade900,),
          ),
          body: ListView.builder(
              itemCount: userDetails?['tasks'].length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(key: Key(todos[index]), child: InkWell(
                  onLongPress:() {
                    setState(() {
                      done[index] = done[index]? false : true;
                      db.collection('MentalHealth').doc(widget.id).update({
                        'Done' : done
                      });
                    });
                  },
                  child: Card(
                    color: Colors.green.shade100,
                    margin: EdgeInsets.all(8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.green.shade900,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: done[index],
                              onChanged:(bool? value){
                                setState(() {
                                  done[index] = value!;
                                  db.collection('MentalHealth').doc(widget.id).update({
                                    'Done' : done,
                                  });
                                });
                              }
                          ),
                          Text(
                              userDetails?['tasks'][index],
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: done[index]? TextDecoration.lineThrough : null,
                              ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: ()async{
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        contentPadding:const EdgeInsets.all(10),
                                        title: Text("Update Item"),
                                        content: TextField(
                                          controller:
                                          TextEditingController(text: todos[index]),
                                          onChanged: (String value) {
                                            setState(() {
                                              input = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green)
                                              )
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                if(input != ""){
                                                  setState(() {
                                                    todos[index] = input;
                                                    db.collection('MentalHealth').doc(widget.id).update({
                                                      'tasks' : todos,
                                                    });
                                                    input = "";
                                                  });
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Update"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green
                                              ),

                                          )
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: Icon(Icons.edit,color: Colors.green.shade700,)
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.green.shade700,),
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                                done.removeAt(index);
                                dates.removeAt(index);
                                db.collection('MentalHealth').doc(widget.id).update({
                                  'tasks' : todos,
                                  'Done' : done,
                                  'timestamp' : dates,
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(
                        dates[index]
                      ),
                    ),
                  ),
                ),
                    onDismissed: (direction){
                      setState(() {
                        todos.removeAt(index);
                        done.removeAt(index);
                        dates.removeAt(index);
                        db.collection('MentalHealth').doc(widget.id).update({
                          'tasks' : todos,
                          'Done' : done,
                          'timestamp' : dates,
                        });
                      });
                    },
                );
              }
          ),
        );
      }
    );
  }


}
