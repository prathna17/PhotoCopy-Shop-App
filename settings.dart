import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'forgot_password.dart';
import 'imagehandler.dart';
class page extends StatefulWidget {
  const page({Key? key}) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> with TickerProviderStateMixin,ImagePickerListener{
  late TextEditingController controller;

  String Email=FirebaseAuth.instance.currentUser?.email as String;
  //final networkHandler = NetworkHandler(child: null,);
  late File _image=File("assets/co.png");
  late AnimationController _controller;
  late ImagePickerHandler imagePicker;
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    /*_controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();*/
  }

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance
        .ref().child("profile.png");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }


  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    void submit(){
      Navigator.of(context).pop(controller.text);
    }

    String string;
    return Scaffold(
      backgroundColor: Color(0xFF472478),
      appBar: AppBar(
        // toolbarHeight: 80,
        backgroundColor: Color.fromARGB(444, 150, 89, 205),
        elevation: 0.0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(25),
        //   ),
        // ),
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
        centerTitle: true,
        title: Text('Settings', style: TextStyle(color: Colors.white),),

      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 24),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: Center(
                  child: profilePicLink == " " ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ) : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(profilePicLink),
                  ),
                ),
              ),
            ),
            /*new GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: _image == null
                    ? new Stack(
                  children: <Widget>[


                    new Center(
                      child: new CircleAvatar(
                        radius: 80.0,
                        backgroundColor: const Color(0xFF778899),
                        backgroundImage: userImage(_image),
                      ),
                    ),
                    new Center(
                      child: new Image.asset("assets/—Pngtree—camera icon_4945903.png"),
                    ),

                  ],
                )
                    : new Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      image: new ExactAssetImage(_image.path),
                      fit: BoxFit.cover,
                    ),
                    border:
                    Border.all(color: Colors.red, width: 5.0),
                    borderRadius:
                    new BorderRadius.all(const Radius.circular(80.0)),
                  ),
                ),
              ),
            ),*/
            SizedBox(
              height: 10,
            ),
            Container(
              width: 240.0,
              height: 42.0,
              padding: new EdgeInsets.only(top: 14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.deepPurple[200],
              ),
              child: Text("  Email ID: "+Email,style: TextStyle(color: Color(0xFFFFFFFF))),


            ),
            SizedBox(height: 20,),
            FloatingActionButton.extended(
                heroTag:"Change Password",
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                  );
                },
                label: Text('Change Password'),
                backgroundColor: Colors.purple[200]
            ),
            // ListTile(
            //   tileColor: Colors.purple[200],
            //   title: Text("Change Password", style: TextStyle(color: Color(0xFFFFFFFF))),
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            //     );
            //   },
            // ),

          ],
        ),
      ),
    );
  }
}