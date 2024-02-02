import 'package:flutter/material.dart';
import 'Register and registration screen/register.dart';
import 'login.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder:(context)=>Scaffold(
        body:
        Container(
          width:MediaQuery.of(context).size.width,
          //height: 600,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50), ),
            color: Color(0xcc482478),
            image: DecorationImage(
              image: AssetImage('assets/WelcomeStick.png'),
              alignment: Alignment.topCenter,
            ),
          ),

          // Container(

          // height:850,
          // width:500,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/home.png')
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                height: 250,
              ),
              Text(
                "XEROX",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontFamily: 'Oswald',

                ),
              ),Text(
                "Notes bane dost",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Oswald',
                ),
              ),new SizedBox(
                height: 50,
              ),
              new SizedBox(
                  width: 150,
                  height: 40,
                  child: FloatingActionButton.extended(
                      heroTag:"signin",
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      label: Text('Sign in'),
                      backgroundColor: Colors.purple[200]
                  )
              ),
              new SizedBox(
                height: 20,
              ),
              new SizedBox(
                  width: 150,
                  height: 40,
                  child: FloatingActionButton.extended(
                    heroTag: 'login',
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    label: Text('Login',),
                    backgroundColor: Colors.purple[200],
                  )
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}