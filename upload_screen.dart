import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'confirmation_1.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_api.dart';
import 'buttonWidget.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home.dart';

class Upload extends StatelessWidget {
  static final String title = 'Upload';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.purple),
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _numberOfCopiesController = TextEditingController();
  String selectedValue = "Black-White";
  int price = 2;
  bool isuploaded = false;
  final myController = TextEditingController();
  late DatabaseReference dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Uploads');
  }
  //type of printout needed
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Coloured"), value: "Coloured"),
      DropdownMenuItem(child: Text("Black-White"), value: "Black-White"),
    ];
    return menuItems;
  }
  UploadTask? task;
  File? file;


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(Upload.title),
        elevation: 0,
        backgroundColor: Color.fromARGB(444, 150, 89, 205),
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading:
        IconButton(
          color: Color.fromARGB(255, 238, 233, 239),
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CSE()),
            ),
          },
        ),
      ),

      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Upload.png'), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.all(32),
        child:SingleChildScrollView(
          child :Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton.extended(
                        heroTag:"Select File",
                        onPressed: selectFile,
                        label: Text('Select File'),
                        //   icon: Icons.attach_file,
                        backgroundColor: Colors.purple[200]
                    ),
                    // ButtonWidget(
                    //   text: 'Select File',
                    //   icon: Icons.attach_file,
                    //   onClicked: selectFile,
                    // ),
                    SizedBox(height: 8),
                    Text(
                      fileName,
                      style: TextStyle(fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          // height: 40,
                          child: Text('  Number of copies:   ',
                              textAlign: TextAlign.left,
                              style: TextStyle(

                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ),
                        Container(
                          width: 110,
                          //   height: 80,
                          child: TextField(
                            controller: _numberOfCopiesController,
                            decoration: InputDecoration(
                              hintText : "0",
                            ),
                          ),
                        ),
                      ],

                    ),
                    //SizedBox(height: 5),
                    Row(
                      children: [
                        new Text('  Print type:                             ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        new DropdownButton(
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                              if (selectedValue == 'Coloured') {
                                price = 5;
                              }
                              else {
                                price = 2;
                              }
                            },
                            items: dropdownItems
                        )
                      ],
                    ),
                    SizedBox(height: 20),


                    Row(
                      children: [
                        new Text("  Cost/page:                                 ",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        new SizedBox(
                          child: Text(price.toString()),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    FloatingActionButton.extended(
                        heroTag:"Upload File",
                        onPressed: uploadFile,
                        label: Text('Upload File'),
                        //   icon: Icons.attach_file,
                        backgroundColor: Colors.purple[200]
                    ),

                    // ButtonWidget(
                    //   text: 'Upload File',
                    //   icon: Icons.cloud_upload_outlined,
                    //   onClicked: uploadFile,
                    // ),
                    SizedBox(height: 20),
                    //  SizedBox(height: 20),
                    task != null ? buildUploadStatus(task!) : Container(),
                    FloatingActionButton.extended(
                        heroTag:"Done",
                        onPressed: () =>{
                          if(isuploaded){
                            print(FirebaseAuth.instance.currentUser?.email),
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Confirmation()),
                            ),

                          }else{
                            null
                          }
                        },
                        label: Text('Done'),
                        //   icon: Icons.attach_file,
                        backgroundColor: Colors.purple[200]
                    ),

                    //  task != null ? buildUploadStatus(task!) : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    Map<String, String > uploads = {
      'email':FirebaseAuth.instance.currentUser?.email as String,
      'fileName':fileName,
      'fileUrl': urlDownload,
      "no of copies": _numberOfCopiesController.text,
      "print type": selectedValue
    };
    dbRef.push().set(uploads);
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) =>
      StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            if (percentage == "100.00") {
              isuploaded = true;
            }
            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

//
//
// class Upload extends StatelessWidget {
//   static final String title = 'Upload';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData(primarySwatch: Colors.purple),
//     home: MainPage(),
//   );
// }
//
//
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   @override
//   void initState(){
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Uploads');
//
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     //   String? title = message.notification!.title;
//     //   String? body = message.notification!.body;
//     //   AwesomeNotifications().createNotification(content: NotificationContent(id: 123,
//     //     channelKey:  "Print_my_files",
//     //     color: Colors.white,
//     //     title: title,
//     //     body: body,
//     //     category: NotificationCategory.Alarm,
//     //     wakeUpScreen: true,
//     //     fullScreenIntent: true,
//     //     autoDismissible: false,
//     //     backgroundColor: Colors.orange,
//     //   ),
//     //       actionButtons: [
//     //         NotificationActionButton(key: "open", label: "Open App",
//     //           color : Colors.green,
//     //           autoDismissible: true,
//     //         ),
//     //       ]);
//     //   // AwesomeNotifications().actionStream.listen((event){
//     //   //
//     //   // })
//     // });
//   }
//   TextEditingController _numberOfCopiesController = TextEditingController();
//   String selectedValue = "Black-White";
//   int price = 2;
//   bool isuploaded = false;
//   final myController = TextEditingController();
//   late DatabaseReference dbRef;
//
//
//   //type of printout needed
//   List<DropdownMenuItem<String>> get dropdownItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(child: Text("Coloured"), value: "Coloured"),
//       DropdownMenuItem(child: Text("Black-White"), value: "Black-White"),
//     ];
//     return menuItems;
//   }
//   UploadTask? task;
//   File? file;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Upload.title),
//         centerTitle: true,
//       ),
//
//       body:Container(
//         padding: EdgeInsets.all(32),
//         child:SingleChildScrollView(
//           child :Center(
//
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ButtonWidget(
//                       text: 'Select File',
//                       icon: Icons.attach_file,
//                       onClicked: selectFile,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       fileName,
//                       style: TextStyle(fontSize: 15.0,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2.0,
//                           color: Colors.black),
//                     ),
//                     SizedBox(height: 48),
//
//                     Row(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           child: Text('  Number of copies:   ',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 2.0,
//                                 color: Colors.black,
//                               )),
//                         ),
//                         Container(
//                           width: 110,
//                           height: 110,
//                           child: TextField(
//                             controller: _numberOfCopiesController,
//                             decoration: InputDecoration(
//                               hintText : "1",
//
//                             ),
//                           ),
//                         ),
//                       ],
//
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         new Text('  Print type:   ',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 1.0,
//                               fontSize: 20,
//                             )),
//                         new DropdownButton(
//                             value: selectedValue,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedValue = newValue!;
//                               });
//                               if (selectedValue == 'Coloured') {
//                                 price = 5;
//                               }
//                               else {
//                                 price = 2;
//                               }
//                             },
//                             items: dropdownItems
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 20),
//
//
//                     Row(
//                       children: [
//                         new Text("  Cost/page:    ",
//                             style: TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 1.0,
//                               fontSize: 20,
//                             )),
//                         new SizedBox(
//                           child: Text(price.toString()),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//
//
//                     ButtonWidget(
//                       text: 'Upload File',
//                       icon: Icons.cloud_upload_outlined,
//                       onClicked: uploadFile,
//                     ),
//                     SizedBox(height: 20),
//                     //  SizedBox(height: 20),
//                     task != null ? buildUploadStatus(task!) : Container(),
// //
//                     ButtonWidget(icon: Icons.check, text: "Done", onClicked: () =>{
//                       if(isuploaded){
//                         print(FirebaseAuth.instance.currentUser?.email),
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Confirmation()),
//                         ),
//
//                       }else{
//                         null
//                       }
//                     }
//                     )
//                     //  task != null ? buildUploadStatus(task!) : Container(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//
//     if (result == null) return;
//     final path = result.files.single.path!;
//
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//
//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {
//     });
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     Map<String, String > uploads = {
//       'email':FirebaseAuth.instance.currentUser?.email as String,
//       'file': urlDownload,
//       "no of copies": _numberOfCopiesController.text,
//       "print type": selectedValue
//     };
//     dbRef.push().set(uploads);
//     print('Download-Link: $urlDownload');
//   }
//
//   Widget buildUploadStatus(UploadTask task) =>
//       StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//             if (percentage == "100.00") {
//               isuploaded = true;
//             }
//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Container();
//           }
//         },
//       );
// }





//
//
// class Upload extends StatelessWidget {
//   static final String title = 'Upload';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData(primarySwatch: Colors.purple),
//     home: MainPage(),
//   );
// }
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   TextEditingController _numberOfCopiesController = TextEditingController();
//   String selectedValue = "Black-White";
//   int price = 2;
//   bool isuploaded = false;
//   final myController = TextEditingController();
//   late DatabaseReference dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Uploads');
//   }
//   //type of printout needed
//   List<DropdownMenuItem<String>> get dropdownItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(child: Text("Coloured"), value: "Coloured"),
//       DropdownMenuItem(child: Text("Black-White"), value: "Black-White"),
//     ];
//     return menuItems;
//   }
//   UploadTask? task;
//   File? file;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Upload.title),
//         centerTitle: true,
//       ),
//
//       body:Container(
//         padding: EdgeInsets.all(32),
//         child:SingleChildScrollView(
//           child :Center(
//
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ButtonWidget(
//                       text: 'Select File',
//                       icon: Icons.attach_file,
//                       onClicked: selectFile,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       fileName,
//                       style: TextStyle(fontSize: 15.0,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2.0,
//                           color: Colors.black),
//                     ),
//                     SizedBox(height: 48),
//
//                     Row(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           child: Text('  Number of copies:   ',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 2.0,
//                                 color: Colors.black,
//                               )),
//                         ),
//                         Container(
//                           width: 110,
//                           height: 110,
//                           child: TextField(
//                             controller: _numberOfCopiesController,
//                             decoration: InputDecoration(
//                               hintText : "1",
//
//                             ),
//                           ),
//                         ),
//                       ],
//
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         new Text('  Print type:   ',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 1.0,
//                               fontSize: 20,
//                             )),
//                         new DropdownButton(
//                             value: selectedValue,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedValue = newValue!;
//                               });
//                               if (selectedValue == 'Coloured') {
//                                 price = 5;
//                               }
//                               else {
//                                 price = 2;
//                               }
//                             },
//                             items: dropdownItems
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 20),
//
//
//                     Row(
//                       children: [
//                         new Text("  Cost/page:    ",
//                             style: TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 1.0,
//                               fontSize: 20,
//                             )),
//                         new SizedBox(
//                           child: Text(price.toString()),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//
//
//                     ButtonWidget(
//                       text: 'Upload File',
//                       icon: Icons.cloud_upload_outlined,
//                       onClicked: uploadFile,
//                     ),
//                     SizedBox(height: 20),
//                     //  SizedBox(height: 20),
//                     task != null ? buildUploadStatus(task!) : Container(),
// //
//                     ButtonWidget(icon: Icons.check, text: "Done", onClicked: () =>{
//                       if(isuploaded){
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Confirmation()),
//                         ),
//                       }else{
//                         null
//                       }
//                     }
//                     )
//                     //  task != null ? buildUploadStatus(task!) : Container(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//
//     if (result == null) return;
//     final path = result.files.single.path!;
//
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//
//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {
//     });
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     Map<String, String > uploads = {
//       'file': fileName,
//       "no of copies": _numberOfCopiesController.text,
//       "print type": selectedValue
//     };
//     dbRef.push().set(uploads);
//     print('Download-Link: $urlDownload');
//   }
//
//   Widget buildUploadStatus(UploadTask task) =>
//       StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//             if (percentage == "100.00") {
//               isuploaded = true;
//             }
//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Container();
//           }
//         },
//       );
// }

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   await Firebase.initializeApp();
//   runApp(Upload());
// }
//
// class Upload extends StatelessWidget {
//   static final String title = 'Upload';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData(primarySwatch: Colors.purple),
//     home: MainPage(),
//   );
// }
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   TextEditingController _numberOfCopiesController = TextEditingController();
//   String selectedValue = "Black-White";
//   int price = 2;
//   bool isuploaded = false;
//   final myController = TextEditingController();
//
//   //type of printout needed
//   List<DropdownMenuItem<String>> get dropdownItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(child: Text("Coloured"), value: "Coloured"),
//       DropdownMenuItem(child: Text("Black-White"), value: "Black-White"),
//     ];
//     return menuItems;
//   }
//   UploadTask? task;
//   File? file;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Upload.title),
//         centerTitle: true,
//       ),
//
//       body:Container(
//         padding: EdgeInsets.all(32),
//         child:SingleChildScrollView(
//         child :Center(
//
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // Card(
//               //   shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(30)),
//               //   margin: EdgeInsets.symmetric(
//               //     horizontal: 25.0,
//               //   ),
//               //   color: Color.fromARGB(444, 150, 89, 205),
//               //   child: ListTile(
//               //     shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(30)),
//               //     title: Text(
//               //       'Select file',
//               //       style: TextStyle(
//               //         fontSize: 15.0,
//               //         fontWeight: FontWeight.bold,
//               //         letterSpacing: 2.0,
//               //         color: Color.fromARGB(255, 254, 253, 255),
//               //       ),
//               //     ),
//               //
//               //     onTap: selectFile,
//               //   ),
//               // ),
//
//
//
//
//
//               ButtonWidget(
//                 text: 'Select File',
//                 icon: Icons.attach_file,
//                 onClicked: selectFile,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 fileName,
//                 style: TextStyle(fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2.0,
//                   color: Colors.black),
//               ),
//               SizedBox(height: 48),
//
//               Row(
//                 children: [
//                  Container(
//                    width: 110,
//                    height: 110,
//                    child: Text('  Number of copies:   ',
//                        textAlign: TextAlign.left,
//                        style: TextStyle(
//
//                          fontSize: 15.0,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 2.0,
//                          color: Colors.black,
//                        )),
//                  ),
//                   Container(
//                     width: 110,
//                     height: 110,
//                     child: TextField(decoration: InputDecoration(
//                       hintText : "1",
//                   ),
//                   ),
//                   ),
//                 ],
//
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   new Text('  Print type:   ',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Colors.black,
//                         letterSpacing: 1.0,
//                         fontSize: 20,
//                       )),
//                   new DropdownButton(
//                       value: selectedValue,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedValue = newValue!;
//                         });
//                         if (selectedValue == 'Coloured') {
//                           price = 5;
//                         }
//                         else {
//                           price = 2;
//                         }
//                       },
//                       items: dropdownItems
//                   )
//                 ],
//               ),
//               SizedBox(height: 20),
//
//
//               Row(
//                 children: [
//                   new Text("  Cost/page:    ",
//                       style: TextStyle(
//                         color: Colors.black,
//                         letterSpacing: 1.0,
//                         fontSize: 20,
//                       )),
//                   new SizedBox(
//                     child: Text(price.toString()),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//
//               ButtonWidget(
//                 text: 'Upload File',
//                 icon: Icons.cloud_upload_outlined,
//                 onClicked: uploadFile,
//               ),
//               SizedBox(height: 20),
//               //  SizedBox(height: 20),
//               task != null ? buildUploadStatus(task!) : Container(),
// //
//               ButtonWidget(icon: Icons.check, text: "Done", onClicked: () =>{
//                 if(isuploaded){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Confirmation()),
//                   ),
//                 }else{
//                   null
//                 }
//               }
//                   )
//               //  task != null ? buildUploadStatus(task!) : Container(),
//             ],
//           ),
//           ],
//         ),
//         ),
//       ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//
//     if (result == null) return;
//     final path = result.files.single.path!;
//
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//
//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//
//     print('Download-Link: $urlDownload');
//   }
//
//   Widget buildUploadStatus(UploadTask task) =>
//       StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//             if (percentage == "100") {
//               isuploaded = true;
//             }
//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Container();
//           }
//         },
//       );
// }
