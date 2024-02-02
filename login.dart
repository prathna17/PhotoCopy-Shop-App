import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_services.dart';
import 'forgot_password.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reusable_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_services.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reusable_widget.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _EmailTextController = TextEditingController();
  // EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          elevation: 0,
          backgroundColor: Color.fromARGB(444, 150, 89, 205),
          automaticallyImplyLeading: true,
          leading:
          IconButton( onPressed: (){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Login.png'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Column(children:[

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40
                ),
                child:Column(children:[
                  reusableTextField("Enter Email", Icons.email, false, _EmailTextController),
                  SizedBox(
                    height: 30,
                  ),
                ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40
                ),

                child:Column(children: [
                  reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                ],
                ),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("",
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'Inria Serif')),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: const Text(
                        " Forgot password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inria Serif',
                          decoration: TextDecoration.underline,
                        ),
                      ))
                ],
              ),
              SigninSignupButton(context, true, (){
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _EmailTextController.text,
                    password: _passwordTextController.text).then((value)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CSE()),
                  );
                });
              },)
            ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _EmailTextController = TextEditingController();
//  // EmailOTP myauth = EmailOTP();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.purple[800],
//           leading:
//           IconButton( onPressed: (){
//             Navigator.pop(context);
//           },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [Column(children:[
//
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 40
//                 ),
//                 child:Column(children:[
//                   reusableTextField("Enter Email", Icons.email, false, _EmailTextController),
//                   SizedBox(
//                     height: 30,
//                   ),
//                 ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 40
//                 ),
//
//                 child:Column(children: [
//                   reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//                 ),
//               ),
//               SigninSignupButton(context, true, (){
//                 FirebaseAuth.instance.signInWithEmailAndPassword(email: _EmailTextController.text,
//                     password: _passwordTextController.text).then((value)
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CSE()),
//                   );
//                 });
//               },)
//             ],
//             ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }








//
// import 'services/firebase_services.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   static Future<User?> loginUsingEmailPassword(
//       {required String email,
//         required String password,
//         required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "user-not-found") {
//         print("No user found for that email");
//       }
//     }
//
//     return user;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _passwordTextController = TextEditingController();
//     TextEditingController _EmailTextController = TextEditingController();
//
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/Register.png'), fit: BoxFit.cover),
//           ),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//               child: Column(
//                 children: <Widget>[
//                   reusableTextField(
//                       "Enter Email", Icons.email, false, _EmailTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField("Enter Password", Icons.lock_outline, true,
//                       _passwordTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   //SigninSignupButton(
//                   //  context,
//                   //  true,
//                   //  () async {
//                   //    User? user = await loginUsingEmailPassword(
//                   //        email: _EmailTextController.text,
//                   //        password: _passwordTextController.text,
//                   //        context: context);
//                   //    print(user);
//                   //    if (user != null) {
//                   //      Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   //        builder: (context) => CSE(),
//                   //      ));
//                   //    }
//                   //  },
//                   //),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
//                     decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     child: ElevatedButton(
//                       //fillColor: Color.fromARGB(0, 24, 24, 25),
//                       //elevation: 0.0,
//                       //padding: EdgeInsets.symmetric(vertical: 20.0),
//                       //shape: RoundedRectangleBorder(
//                       //    borderRadius: BorderRadius.circular(12.0)),
//                       onPressed: () async {
//                         User? user = await loginUsingEmailPassword(
//                             email: _EmailTextController.text,
//                             password: _passwordTextController.text,
//                             context: context);
//                         print(user);
//                         if (user != null) {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute(
//                             builder: (context) => CSE(),
//                           ));
//                         }
//                       },
//                       child: Text(
//                         "Login",
//                         style: const TextStyle(
//                             color: Color.fromARGB(255, 247, 245, 245),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 24,
//                             fontFamily: 'Inria_Serif'),
//                       ),
//                       style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.resolveWith((states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return Color.fromARGB(197, 68, 68, 68);
//                             }
//                             return Color.fromARGB(255, 28, 118, 160);
//                           }),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(12)))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
//                     decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     child: ElevatedButton(
//                       //fillColor: Color.fromARGB(0, 24, 24, 25),
//                       //elevation: 0.0,
//                       //padding: EdgeInsets.symmetric(vertical: 20.0),
//                       //shape: RoundedRectangleBorder(
//                       //    borderRadius: BorderRadius.circular(12.0)),
//                       onPressed: () async {
//                         await FirebaseServices().signInWithGoogle();
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => CSE()));
//
//                         User? user = await loginUsingEmailPassword(
//                             email: _EmailTextController.text,
//                             password: _passwordTextController.text,
//                             context: context);
//                         print(user);
//                         if (user != null) {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute(
//                             builder: (context) => CSE(),
//                           ));
//                         }
//                       },
//                       child: Row(children: <Widget>[
//                         new Image.asset(
//                           'assets/google.png',
//                           height: 30.0,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         new Expanded(
//                           child: Text(
//                             textAlign: TextAlign.center,
//                             "SignIn With Google",
//                             style: const TextStyle(
//                                 color: Color.fromARGB(255, 69, 68, 68),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 24,
//                                 fontFamily: 'Inria_Serif'),
//                           ),
//                         ),
//                       ]),
//
//                       style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.resolveWith((states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return Color.fromARGB(197, 87, 86, 86);
//                             }
//                             return Color.fromARGB(255, 183, 186, 186);
//                           }),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(12)))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//

///////////////////////////////////////////////////////
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
//
//
//
// class _LoginState extends State<Login> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _EmailTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage('assets/Register.png'), fit: BoxFit.cover),
//           ),
//           child:SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//               child: Column(
//                 children: <Widget>[
//                   reusableTextField("Enter Email", Icons.email, false, _EmailTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
//                     decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     child: ElevatedButton(
//                       //fillColor: Color.fromARGB(0, 24, 24, 25),
//                       //elevation: 0.0,
//                       //padding: EdgeInsets.symmetric(vertical: 20.0),
//                       //shape: RoundedRectangleBorder(
//                       //    borderRadius: BorderRadius.circular(12.0)),
//                       onPressed: () async {
//                         await FirebaseServices().signInWithGoogle();
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => CSE()));
//
//                         // User? user = await loginUsingEmailPassword(
//                         //     email: _EmailTextController.text,
//                         //     password: _passwordTextController.text,
//                         //     context: context);
//                         // print(user);
//                         // if (user != null) {
//                         //   Navigator.of(context)
//                         //       .pushReplacement(MaterialPageRoute(
//                         //     builder: (context) => CSE(),
//                       //    ));
//                       //  }
//                       },
//                       child: Row(children: <Widget>[
//                         new Image.asset(
//                           'assets/google icon.jpg',
//                           height: 30.0,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         new Expanded(
//                           child: Text(
//                             textAlign: TextAlign.center,
//                             "SignIn With Google",
//                             style: const TextStyle(
//                                 color: Color.fromARGB(255, 69, 68, 68),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 24,
//                                 fontFamily: 'Inria_Serif'),
//                           ),
//                         ),
//                       ]),
//
//                       style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.resolveWith((states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return Color.fromARGB(197, 87, 86, 86);
//                             }
//                             return Color.fromARGB(255, 183, 186, 186);
//                           }),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(12)))),
//                     ),
//                   ),
//
//                   SigninSignupButton(context, true, (){
//                     FirebaseAuth.instance.signInWithEmailAndPassword(email: _EmailTextController.text,
//                         password: _passwordTextController.text).then((value)
//                     {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => CSE()),
//                       );
//                     });
//                   },)
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//       ),
//     );
//   }
// }////////////////////////////////////////////////////
// //
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _EmailTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage('assets/Register.png'), fit: BoxFit.cover),
//           ),
//           child: ListView(
//             children: <Widget>[
//               Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                 child: TextField(
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom),
//                   controller: _EmailTextController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       labelText: 'Enter Email ID',
//                       filled: true,
//                       fillColor: Colors.purple[200]),
//                 ),
//               ),
//               Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                 child: TextField(
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom),
//                   controller: _passwordTextController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       labelText: 'Enter Password',
//                       filled: true,
//                       fillColor: Colors.purple[200]),
//                 ),
//               ),
//               new SizedBox(
//                   width: 220,
//                   height: 40,
//                   child: FloatingActionButton.extended(
//                       heroTag: 'login',
//                       onPressed: () {
//                         FirebaseAuth.instance
//                             .signInWithEmailAndPassword(
//                             email: _EmailTextController.text,
//                             password: _passwordTextController.text)
//                             .then((value) {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => CSE()));
//                         }).onError((error, stackTrace) {
//                           print("Error ${error.toString()}");
//                         });
//                       },
//                       label:
//                       Text('Login', style: TextStyle(color: Colors.black)),
//                       backgroundColor: Colors.white)),
//               Text('OR', style: TextStyle(fontSize: 35, color: Colors.black)),
//               new SizedBox(
//                   width: 220,
//                   height: 40,
//                   child: FloatingActionButton.extended(
//                     heroTag: 'google',
//                     onPressed: () {},
//                     label: Text('Login in with Google'),
//                     icon: Image.asset('assets/google icon.jpg',
//                         height: 30, width: 30),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               new SizedBox(
//                 width: 220,
//                 height: 40,
//                 child: FloatingActionButton.extended(
//                   heroTag: 'apple',
//                   onPressed: () {},
//                   label: Text('Login in with Apple'),
//                   icon: Image.asset('assets/apple.png', height: 32, width: 32),
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


