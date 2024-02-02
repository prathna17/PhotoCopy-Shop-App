import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final key=GlobalKey<FormState>();
  sendEmail(String recipientEmail) async{
    final Email email=Email(
      recipients: [recipientEmail],
      isHTML:false,
    );
    await FlutterEmailSender.send(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF472478),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFFDAD8DB),
        elevation: 0.0,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
        centerTitle: true,
        title: Text('Help Center', style: TextStyle(color: Color(0xFF6B00F7), fontSize: 43, fontWeight: FontWeight.w400),),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                      sendEmail('prathna1705@gmail.com');

                  },
                  child: Text('Email'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}