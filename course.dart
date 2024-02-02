import 'package:flutter/material.dart';
import 'home.dart';


class CourseS extends StatelessWidget {
  const CourseS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('COURSES'),
          titleTextStyle: TextStyle(
            fontSize: 35.0,
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple[600],
        ),


        body: Column(children: <Widget>[
          SizedBox(
              height: 37
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              //ROW 1
              children: [
                Container(

                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'CSE',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(

                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'CSE AI',
                      style: TextStyle(fontSize: 20),

                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ]
          ),
          SizedBox(
              height: 10
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,//ROW 2
              children: [
                Container(

                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'ECE',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(

                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'ECE AI',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

              ]),
          SizedBox(
              height: 10
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,// ROW 3
              children: [
                Container(
                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'MAE',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'IT',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ]),
          SizedBox(
              height: 10
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,// ROW 4
              children: [
                Container(
                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'DMAM',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CSE()),
                      );
                    },
                    child: const Text(
                      'BBA',
                      style: TextStyle(fontSize: 20),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200], //background color of button
                      side: BorderSide(width:2, color:Colors.black), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ]),


        ]
        ),
        backgroundColor: Colors.purple[600],
      ),
    );

  }
}