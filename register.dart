import '../home.dart';
import '../reusable_widget.dart';
import 'package:flutter/material.dart';
//import 'firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_otp/email_otp.dart';

import 'package:email_auth/email_auth.dart';
//
import 'package:flutter/material.dart';
import '../terms.dart';
//import 'services/firebase_services.dart';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';




class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool agree = false;
  bool emailVerified = false;
  bool submitValid = false;


  TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _EmailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _otpcontroller = TextEditingController();
  EmailOTP myauth = EmailOTP();
  EmailAuth? emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Register for photocopy shop",
    );

    /// Configuring the remote server
    //
    var remoteServerConfiguration = {
      "server": "server url",
      "serverKey": "Mljs57"
    };
    //emailAuth.config(remoteServerConfiguration);
  }

  /// a void function to verify if the Data provided is true
  /// Convert it into a boolean function to match your needs.


  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  ///

  void sendOtp() async {
    await myauth.setConfig(
        appEmail: "parikhaitan132@gmail.com",
        appName: "Email OTP",
        userEmail: _EmailTextController.value.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly
    );
    await myauth.sendOTP();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
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
            image: DecorationImage(
                image: AssetImage('assets/Login.png'), fit: BoxFit.cover
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 20,
                  // ),
                  reusableTextField(
                      "Enter UserName", Icons.person_outline, false,
                      _userNameTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      "Enter Email", Icons.email, false, _EmailTextController),

                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Inria Serif')),
                      GestureDetector(
                          onTap: sendOtp,
                          child: const Text(
                            " Request OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inria Serif',
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                  // SizedBox(
                  //     height: 50,
                  //     width: 200,
                  //     child:FloatingActionButton.extended(
                  //         heroTag:"Request OTP",
                  //         onPressed: sendOtp,
                  //         label: Text('Request OTP'),
                  //         backgroundColor: Colors.purple[200]
                  //     ),
                  //   ),
                  SizedBox(
                    height: 5,
                  ),

                  Card(
                    child: SizedBox(
                      width: 100.0,
                      height: 30.0,
                      child: TextField(
                        controller: _otpcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                          ),
                        ),
                        style: TextStyle(fontSize: 20.0, height: 2.0, color: Colors.black),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Inria Serif')),
                      GestureDetector(
                          onTap: () async {
                            if(await myauth.verifyOTP(
                                otp: _otpcontroller.value.text
                            ) == true){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Verification'),
                                  content: const Text('Your OTP has been verified'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Verification'),
                                  content: const Text('Your OTP has not been verified'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Verify",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inria Serif',
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                  // SizedBox(
                  //
                  //   height: 50,
                  //   width: 200,
                  //   child:FloatingActionButton.extended(
                  //       heroTag:"Request OTP",
                  //       onPressed: () async {
                  //         if(await myauth.verifyOTP(
                  //             otp: _otpcontroller.value.text
                  //         ) == true){
                  //           showDialog<String>(
                  //             context: context,
                  //             builder: (BuildContext context) => AlertDialog(
                  //               title: const Text('Verification'),
                  //               content: const Text('Your OTP has been verified'),
                  //               actions: <Widget>[
                  //                 TextButton(
                  //                   onPressed: () => Navigator.pop(context, 'OK'),
                  //                   child: const Text('OK'),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }else{
                  //           showDialog<String>(
                  //             context: context,
                  //             builder: (BuildContext context) => AlertDialog(
                  //               title: const Text('Verification'),
                  //               content: const Text('Your OTP has not been verified'),
                  //               actions: <Widget>[
                  //                 TextButton(
                  //                   onPressed: () => Navigator.pop(context, 'OK'),
                  //                   child: const Text('OK'),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }
                  //       },
                  //       label: Text('Verify'),
                  //       backgroundColor: Colors.purple[200]
                  //   ),
                  //   // ElevatedButton(
                  //   //   onPressed: () async {
                  //   //     if(await myauth.verifyOTP(
                  //   //         otp: _otpcontroller.value.text
                  //   //     ) == true){
                  //   //       showDialog<String>(
                  //   //         context: context,
                  //   //         builder: (BuildContext context) => AlertDialog(
                  //   //           title: const Text('Verification'),
                  //   //           content: const Text('Your OTP has been verified'),
                  //   //           actions: <Widget>[
                  //   //             TextButton(
                  //   //               onPressed: () => Navigator.pop(context, 'OK'),
                  //   //               child: const Text('OK'),
                  //   //             ),
                  //   //           ],
                  //   //         ),
                  //   //       );
                  //   //     }else{
                  //   //       showDialog<String>(
                  //   //         context: context,
                  //   //         builder: (BuildContext context) => AlertDialog(
                  //   //           title: const Text('Verification'),
                  //   //           content: const Text('Your OTP has not been verified'),
                  //   //           actions: <Widget>[
                  //   //             TextButton(
                  //   //               onPressed: () => Navigator.pop(context, 'OK'),
                  //   //               child: const Text('OK'),
                  //   //             ),
                  //   //           ],
                  //   //         ),
                  //   //       );
                  //   //     }
                  //   //   },
                  //   //
                  //   //   child: Center(
                  //   //     child: Text(
                  //   //       "Verify",
                  //   //       style: TextStyle(
                  //   //         fontWeight: FontWeight.bold,
                  //   //         color: Colors.white,
                  //   //         fontSize: 20,
                  //   //       ),
                  //   //     ),
                  //   //   ),
                  //   // ),
                  // ),
                  SizedBox(height: 1),


                  SigninSignupButton(context, false, () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      //  name  = _userNameTextController;
                        email: _EmailTextController.text,
                        password: _passwordTextController.text).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    });
                  }
                  ),
                  Container(
                     width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: ElevatedButton(
                      //fillColor: Color.fromARGB(0, 24, 24, 25),
                      //elevation: 0.0,
                      //padding: EdgeInsets.symmetric(vertical: 20.0),
                      //shape: RoundedRectangleBorder(
                      //    borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () async {
                        // await FirebaseServices().signInWithGoogle();
                         //Navigator.push(context,
                        // MaterialPageRoute(builder: (context) => CSE()));
                        //
                        // User? user = await loginUsingEmailPassword(
                        //     email: _EmailTextController.text,
                        //     password: _passwordTextController.text,
                        //     context: context);
                        // print(user);
                        // if (user != null) {
                        //   Navigator.of(context)
                        //       .pushReplacement(MaterialPageRoute(
                        //     builder: (context) => CSE(),
                        //   ));
                        // }
                      },
                      child: Row(children: <Widget>[
                        new Image.asset(
                          'assets/google icon.jpg',
                          height: 30.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        new Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            "SignIn With Google",
                            style: const TextStyle(
                                color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                      ]),

                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black;
                            }
                            return Colors.white;
                          }),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:node_from_pc/CreatePassword.dart';
//
// import 'reusable_widget.dart';
// import 'package:flutter/material.dart';
// import 'home.dart';
// import 'firebase_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:email_otp/email_otp.dart';
// // class Login extends StatefulWidget {
// //   const Login({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Login> createState() => _LoginState();
// // }
// //
// // class _LoginState extends State<Login> {
// //   static Future<User?> loginUsingEmailPassword(
// //       {required String email,
// //         required String password,
// //         required BuildContext context}) async {
// //     FirebaseAuth auth = FirebaseAuth.instance;
// //     User? user;
// //     try {
// //       UserCredential userCredential = await auth.signInWithEmailAndPassword(
// //           email: email, password: password);
// //       user = userCredential.user;
// //     } on FirebaseAuthException catch (e) {
// //       if (e.code == "user-not-found") {
// //         print("No user found for that email");
// //       }
// //     }
// //
// //     return user;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     TextEditingController _passwordTextController = TextEditingController();
// //     TextEditingController _EmailTextController = TextEditingController();
// //
// //     return MaterialApp(
// //       home: Scaffold(
// //         body: Container(
// //           decoration: BoxDecoration(
// //             image: DecorationImage(
// //                 image: AssetImage('assets/Register.png'), fit: BoxFit.cover),
// //           ),
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
// //               child: Column(
// //                 children: <Widget>[
// //                   reusableTextField(
// //                       "Enter Email", Icons.email, false, _EmailTextController),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   reusableTextField("Enter Password", Icons.lock_outline, true,
// //                       _passwordTextController),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   //SigninSignupButton(
// //                   //  context,
// //                   //  true,
// //                   //  () async {
// //                   //    User? user = await loginUsingEmailPassword(
// //                   //        email: _EmailTextController.text,
// //                   //        password: _passwordTextController.text,
// //                   //        context: context);
// //                   //    print(user);
// //                   //    if (user != null) {
// //                   //      Navigator.of(context).pushReplacement(MaterialPageRoute(
// //                   //        builder: (context) => CSE(),
// //                   //      ));
// //                   //    }
// //                   //  },
// //                   //),
// //                   Container(
// //                     width: MediaQuery.of(context).size.width,
// //                     height: 50,
// //                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
// //                     decoration:
// //                     BoxDecoration(borderRadius: BorderRadius.circular(12)),
// //                     child: ElevatedButton(
// //                       //fillColor: Color.fromARGB(0, 24, 24, 25),
// //                       //elevation: 0.0,
// //                       //padding: EdgeInsets.symmetric(vertical: 20.0),
// //                       //shape: RoundedRectangleBorder(
// //                       //    borderRadius: BorderRadius.circular(12.0)),
// //                       onPressed: () async {
// //                         User? user = await loginUsingEmailPassword(
// //                             email: _EmailTextController.text,
// //                             password: _passwordTextController.text,
// //                             context: context);
// //                         print(user);
// //                         if (user != null) {
// //                           Navigator.of(context)
// //                               .pushReplacement(MaterialPageRoute(
// //                             builder: (context) => CSE(),
// //                           ));
// //                         }
// //                       },
// //                       child: Text(
// //                         "Login",
// //                         style: const TextStyle(
// //                             color: Color.fromARGB(255, 247, 245, 245),
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 24,
// //                             fontFamily: 'Inria_Serif'),
// //                       ),
// //                       style: ButtonStyle(
// //                           backgroundColor:
// //                           MaterialStateProperty.resolveWith((states) {
// //                             if (states.contains(MaterialState.pressed)) {
// //                               return Color.fromARGB(197, 68, 68, 68);
// //                             }
// //                             return Color.fromARGB(255, 28, 118, 160);
// //                           }),
// //                           shape:
// //                           MaterialStateProperty.all<RoundedRectangleBorder>(
// //                               RoundedRectangleBorder(
// //                                   borderRadius:
// //                                   BorderRadius.circular(12)))),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
//
//
//
//
// import 'package:email_auth/email_auth.dart';
// //
// import 'package:flutter/material.dart';
// import '../terms.dart';
// //import 'services/firebase_services.dart';
// import 'dart:ffi';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'reusable_widget.dart';
//
//
//
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);
//
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   bool agree = false;
//   bool emailVerified = false;
//   bool submitValid = false;
//
//
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _EmailTextController = TextEditingController();
//   TextEditingController _userNameTextController = TextEditingController();
//   TextEditingController _otpcontroller = TextEditingController();
//   EmailOTP myauth = EmailOTP();
//   EmailAuth? emailAuth;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the package
//     emailAuth = new EmailAuth(
//       sessionName: "Register for photocopy shop",
//     );
//
//     /// Configuring the remote server
//     //
//     var remoteServerConfiguration = {
//       "server": "server url",
//       "serverKey": "Mljs57"
//     };
//     //emailAuth.config(remoteServerConfiguration);
//   }
//   TextEditingController returnEmail(){
//     return _EmailTextController;
//   }
//
//   /// a void function to verify if the Data provided is true
//   /// Convert it into a boolean function to match your needs.
//   Future<bool>  verify() async {
//     var inputOTP = _otpcontroller.value.text;  //which is entered by client, after receive mail
//     return await myauth.verifyOTP(
//         otp: inputOTP
//     );
//   }
//   //bool verify() {
//   //   print(emailAuth?.validateOtp(
//   //       recipientMail: _EmailTextController.value.text,
//   //       userOtp: _otpcontroller.value.text));
//   //
//   //   if(myauth.verifyOTP(
//   //   otp: _otpcontroller.value.text
//   //   ) == true){
//   //     return true;
//   //   }else{
//   //     return false;
//   //   }
//   // }
//
//   /// a void funtion to send the OTP to the user
//   /// Can also be converted into a Boolean function and render accordingly for providers
//   ///
//
//   void sendOtp() async {
//     await myauth.setConfig(
//         appEmail: "parikhaitan132@gmail.com",
//         appName: "Email OTP",
//         userEmail: _EmailTextController.value.text,
//         otpLength: 6,
//         otpType: OTPType.digitsOnly
//     );
//     await myauth.sendOTP();
//
//     // bool result = await emailAuth.sendOtp(
//     //  recipientMail: _EmailTextController.value.text, otpLength: 5);
//     //  if (result) {
//     //  setState(() {
//     //   submitValid = true;
//     //  });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/Register.png'), fit: BoxFit.cover
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
//               child: Column(
//                 children: <Widget>[
//                   reusableTextField(
//                       "Enter UserName", Icons.person_outline, false,
//                       _userNameTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField(
//                       "Enter Email", Icons.email, false, _EmailTextController),
//                   SizedBox(
//                     height: 5,
//                   ),
//
//                   Card(
//                     margin: EdgeInsets.only(top: 20),
//                     elevation: 6,
//                     child: Container(
//                       height: 50,
//                       width: 200,
//                       color: Colors.green[400],
//                       child: GestureDetector(
//                         onTap: sendOtp,
//                         child: Center(
//                           child: Text(
//                             "Request OTP",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // A dynamically rendering text field
//                   // (submitValid)
//                   //    ?
//                   Card(
//                     child: SizedBox(
//                       width: 150.0,
//                       height: 40.0,
//                       child: TextField(
//                         controller: _otpcontroller,
//                         style: TextStyle(fontSize: 40.0, height: 2.0, color: Colors.black),
//
//                       ),
//                     ),
//                   ),
//               // TextField(
//               //
//               //
//               //     ),
//                      // : Container(height: 1),
//                   //(submitValid)
//                    //   ?
//                 Container(
//                     margin: EdgeInsets.only(top: 20),
//                     height: 50,
//                     width: 200,
//                     color: Colors.green[400],
//                     child: GestureDetector(
//                       onTap: (){
//                         var inputOTP = _otpcontroller.value.text;  //which is entered by client, after receive mail
//                         // return await myauth.verifyOTP(
//                         //     otp: inputOTP
//                         // );
//                         if(myauth.verifyOTP(
//                         otp: inputOTP
//                         )){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Create_Password()),
//                           );
//                         }else{
//                           new Text("Invalid otp",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 1.0,
//                                 fontSize: 20,
//                               ));
//                         }
//                       },
//
//                       child: Center(
//                         child: Text(
//                           "Verify",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 1),
//
//
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField("Enter Password", Icons.lock_outline, true,
//                       _passwordTextController),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   SigninSignupButton(context, false, () {
//                     FirebaseAuth.instance.createUserWithEmailAndPassword(
//                       //  name  = _userNameTextController;
//                         email: _EmailTextController.text,
//                         password: _passwordTextController.text).then((value) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MyHomePage()),
//                       );
//                     });
//                   }
//                   ),
//                   Container(
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width,
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
//                             MaterialPageRoute(builder: (context) => Create_Password()));
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
//                         //   ));
//                         // }
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
//
//
//
//
//
//
