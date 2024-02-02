import 'package:firebase_project/screens/profile.dart';
import 'package:firebase_project/screens/upload_screen.dart';
import 'package:firebase_project/screens/welcome.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CSE extends StatelessWidget {
  const CSE({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(444, 150, 89, 205),
          automaticallyImplyLeading: true,

          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('My Home'),
          actions: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                });
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                color: Color.fromARGB(444, 150, 89, 205),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  title: Text(
                    'UPLOAD',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Color.fromARGB(255, 254, 253, 255),
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Upload()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 50,
                height: 20,
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30)),
              //   margin: EdgeInsets.symmetric(
              //     horizontal: 25.0,
              //   ),
              //   color: Color.fromARGB(444, 150, 89, 205),
              //   child: ListTile(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30)),
              //     title: Text(
              //       'VIRTUAL',
              //       style: TextStyle(
              //         fontSize: 15.0,
              //         fontWeight: FontWeight.bold,
              //         letterSpacing: 2.0,
              //         color: Color.fromARGB(255, 254, 253, 255),
              //       ),
              //     ),
              //
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Virtual()),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(
              //   width: 50,
              //   height: 20,
              // ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                color: Color.fromARGB(444, 150, 89, 205),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  title: Text(
                    'MY PROFILE',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Color.fromARGB(255, 254, 253, 255),
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// class CSE extends StatelessWidget {
//   const CSE({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(444, 150, 89, 205),
//           automaticallyImplyLeading: true,
//
//           //`true` if you want Flutter to automatically add Back Button when needed,
//           //or `false` if you want to force your own back button every where
//           title: Text('My Home'),
//           actions: <Widget>[
//             ElevatedButton.icon(
//               icon: Icon(Icons.person),
//                 label: Text('Logout'),
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Welcome()),
//                   );
//                 },
//             )
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/HOME (2).png'),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                 ),
//                 color: Color.fromARGB(444, 150, 89, 205),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   title: Text(
//                     'UPLOAD',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2.0,
//                       color: Color.fromARGB(255, 254, 253, 255),
//                     ),
//                   ),
//
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Upload()),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 50,
//                 height: 20,
//               ),
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                 ),
//                 color: Color.fromARGB(444, 150, 89, 205),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   title: Text(
//                     'VIRTUAL',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2.0,
//                       color: Color.fromARGB(255, 254, 253, 255),
//                     ),
//                   ),
//
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Virtual()),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 50,
//                 height: 20,
//               ),
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                 ),
//                 color: Color.fromARGB(444, 150, 89, 205),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40)),
//                   title: Text(
//                     'MY PROFILE',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2.0,
//                       color: Color.fromARGB(255, 254, 253, 255),
//                     ),
//                   ),
//
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Profile()),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }