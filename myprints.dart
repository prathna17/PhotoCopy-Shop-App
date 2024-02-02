import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project/screens/profile.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';


class MyPrints extends StatefulWidget {
  const MyPrints({Key? key}) : super(key: key);

  @override
  State<MyPrints> createState() => _MyPrintsState();
}
class _MyPrintsState extends State<MyPrints> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Uploads');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Uploads');
  bool onClicked=false;
  Color? getColor(){
    if(onClicked==true){
      return Colors.red;
    }
    else{
      return Colors.purple[200];
    }
  }

  Widget listItem({required Map upload}) {
    _launchURL() async {
      var url = upload['fileUrl'];
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    }
    if(upload['email']==FirebaseAuth.instance.currentUser?.email) {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height:170,
        color: Colors.purple[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed:() {
                  _launchURL();
                },
                child:Text(upload["fileName"])
            ),

            const SizedBox(
              height: 5,
            ),
            Text(
              upload['no of copies'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              upload['print type'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed:(){
                  onClicked =true;

                    getColor();

                },
                child:Text("Done")
            ),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(444, 150, 89, 205),
          automaticallyImplyLeading: true,

          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('My Prints'),
          leading: IconButton(
            color: Color.fromARGB(255, 238, 233, 239),
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              ),
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/WhatsApp Image 2022-09-21 at 9.30.42 PM.jpeg"),
                  fit: BoxFit.cover)),

          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              Map upload = snapshot.value as Map;
              upload['key'] = snapshot.key;
              if(FirebaseAuth.instance.currentUser!=null){
                return listItem(upload: upload);

              }
              else{
                return listItem(upload: upload);
              }

            },
          ),
        ),
      ),
    );
  }
}
// class MyPrints extends StatefulWidget {
//   const MyPrints({Key? key}) : super(key: key);
//
//   @override
//   State<MyPrints> createState() => _MyPrintsState();
// }
// class _MyPrintsState extends State<MyPrints> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('Uploads');
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('Uploads');
//
//   Widget listItem({required Map upload}) {
//     if(upload['email']==FirebaseAuth.instance.currentUser?.email) {
//       return Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         height: 200,
//         color: Colors.purple[200],
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               upload['file'],
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Text(
//               upload['no of copies'],
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Text(
//               upload['print type'],
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       );
//     }
//     else{
//       return Container();
//     }
//   }
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
//           title: Text('My Prints'),
//           leading: IconButton(
//             color: Color.fromARGB(255, 238, 233, 239),
//             icon: Icon(Icons.arrow_back),
//             onPressed: () =>
//             {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Profile()),
//               ),
//             },
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                       "assets/WhatsApp Image 2022-09-21 at 9.30.42 PM.jpeg"),
//                   fit: BoxFit.cover)),
//
//           child: FirebaseAnimatedList(
//             query: dbRef,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
//
//               Map upload = snapshot.value as Map;
//               upload['key'] = snapshot.key;
//               if(FirebaseAuth.instance.currentUser!=null){
//                 return listItem(upload: upload);
//
//               }
//               else{
//                 return listItem(upload: upload);
//               }
//
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// class MyPrints extends StatefulWidget {
//   const MyPrints({Key? key}) : super(key: key);
//
//   @override
//   State<MyPrints> createState() => _MyPrintsState();
// }
// class _MyPrintsState extends State<MyPrints> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('Uploads');
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('Uploads');
//
//   Widget listItem({required Map upload}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       color: Colors.purple[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             upload['file'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             upload['no of copies'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             upload['print type'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//         ],
//       ),
//     );
//   }
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
//           title: Text('My Prints'),
//           leading: IconButton(
//             color: Color.fromARGB(255, 238, 233, 239),
//             icon: Icon(Icons.arrow_back),
//             onPressed: () =>
//             {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Profile()),
//               ),
//             },
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                       "assets/WhatsApp Image 2022-09-21 at 9.30.42 PM.jpeg"),
//                   fit: BoxFit.cover)),
//           child: FirebaseAnimatedList(
//             query: dbRef,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
//
//               Map upload = snapshot.value as Map;
//               upload['key'] = snapshot.key;
//
//               return listItem(upload: upload);
//
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//





// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class HistoryPage extends StatefulWidget {
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }
//
// class _HistoryPageState extends State<HistoryPage> {
//   List<String> _uploadedFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUploadedFiles();
//   }
//
//   Future<void> _fetchUploadedFiles() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     FirebaseStorage storage = FirebaseStorage.instance;
//     String userId = 'USER_ID'; // replace with your user ID
//
//     QuerySnapshot querySnapshot = await firestore
//         .collection('uploads')
//         .where('userId', isEqualTo: userId)
//         .get();
//
//     List<String> uploadedFiles = [];
//
//     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
//       String fileName = documentSnapshot.get('fileName');
//       String downloadUrl =
//       await storage.ref(documentSnapshot.get('fileUrl')).getDownloadURL();
//       uploadedFiles.add('$fileName - $downloadUrl');
//     }
//
//     setState(() {
//       _uploadedFiles = uploadedFiles;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload History'),
//       ),
//       body: ListView.builder(
//         itemCount: _uploadedFiles.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_uploadedFiles[index]),
//           );
//         },
//       ),
//     );
//   }
// }