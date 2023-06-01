import 'dart:async';
import 'package:flutter/material.dart';
import '../util/hexcolor.dart';

class breathe extends StatefulWidget {
  const breathe({Key? key}) : super(key: key);

  @override
  State<breathe> createState() => _breatheState();
}

class _breatheState extends State<breathe> {

  List<Color> colors_of_button = [HexColor("#FFFFFF"),HexColor("#FFFFFF"),HexColor("#FFFFFF"),HexColor("#FFFFFF"),HexColor("#FFFFFF")];
  List<Color> changing_colors_of_button = [HexColor("#ADE8F4"),HexColor("#90E0EF"),HexColor("#48CAE4"),HexColor("#00B4D8"),HexColor("#0096C7")];

  Color blue5 = HexColor("#ADE8F4");
  Color blue4 = HexColor("#90E0EF");
  Color blue3 = HexColor("#48CAE4");
  Color blue2 = HexColor("#00B4D8");
  Color blue1 = HexColor("#0096C7");
  Color timer_color = HexColor("#52B69A");
  int timer_count = 0;
  String breathe_instruction = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: breathe_button()
    );
  }




  Widget breathe_button()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            breathe_instruction,
            style: TextStyle(
              color: blue1.withOpacity(1),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            )
        ),
        SizedBox(height: 10,),
        Center(
          child: Container(
            height: 320,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: colors_of_button[0].withOpacity(0.3),
            ),
            child: Center(
              child: Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: colors_of_button[1].withOpacity(0.3),
                ),
                child: Center(
                  child: Container(
                    height: 240,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: colors_of_button[2].withOpacity(0.3),
                    ),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: colors_of_button[3].withOpacity(0.3),
                        ),
                        child: Center(
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: colors_of_button[4].withOpacity(0.3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image:const DecorationImage(image: AssetImage("images/breathe.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                    if(timer_count == 0){
                                      setState(() {
                                        breathe_instruction = "Breathe In";
                                      });
                                    }
                                    breathe_In_function();
                                    Future.delayed(const Duration(seconds: 6), () {
                                      setState(() {
                                        breathe_instruction = "Breathe Out";
                                      });
                                      breathe_Out_function();
                                    });

                                  }

                                ),
                                Text(
                                  "Start",
                                  style: TextStyle(
                                    color: blue1.withOpacity(1),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Text(
            timer_count.toString(),
            style: TextStyle(
              color: timer_color.withOpacity(1),
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }


  void breathe_In_function()
  {
    if(timer_count < 6){
      Future.delayed(const Duration(seconds: 1), () {
        print('One second has passed.');
        setState(() {
          timer_count++;
          colors_of_button[5-timer_count] = changing_colors_of_button[5-timer_count];
        });
        breathe_In_function();
      });
    }
    else{
      print("Function Complete returning");
      return;
    }
  }

  void breathe_Out_function()
  {
    if(timer_count > 0){
      Future.delayed(const Duration(seconds: 1), () {
        print('One second has passed.');
        setState(() {
          timer_count--;
          if(timer_count-1 >= 0){
            colors_of_button[timer_count-1] = HexColor("#FFFFFF");
          }
        });
        breathe_Out_function();
      });
    }
    else{
      print("Function Complete returning");
      return;
    }
  }


}
