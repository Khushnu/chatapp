// ignore_for_file: must_be_immutable

import 'package:chatapp/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreem extends StatelessWidget {
  ChatRoomScreem( {super.key, required this.chatroomId,required this.usermap});
  Map<String, dynamic> usermap;
   final String chatroomId;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final TextEditingController message = TextEditingController();



  void onSendmessages() async{ 
    //  if(message.text.isNotEmpty){
       Map<String, dynamic> messages = {
      'sendby' : firebaseAuth.currentUser!.displayName, 
      'message' : message.text, 
      'time' : FieldValue.serverTimestamp()
     };
     
    await firebaseFirestore.collection('chatroom')
    .doc()
    .collection('chats')
    .add(messages);
    //  } else {
      print('data saved');
        print('enter some text');
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usermap['name']),
      ),
      body: SafeArea(child: Stack(
        children: [
          Column(
          children: [
            Container( 
              height: screenHeight * 0.6, 
              width: screenWidth,
              child: StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore
                .collection('chatroom')
                .doc(chatroomId)
                .collection('chats')
                .orderBy('time', descending: false)
                .snapshots(),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
                  print(usermap['message']);
                if(!snapshot.hasData){
                  return const Center(child: Text('Start You New Chat'),);
                } 
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) 
                    {
                      Map<String, dynamic> d = documentSnapshot.data() as Map<String, dynamic>;
                      return Container(
                        height: 100,
        width: screenWidth, 
        alignment: d['sendby'] == firebaseAuth.currentUser!.displayName ? 
        Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14), 
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8), 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.blue
          ), 
          child: Text(d['message'].toString(), style: TextStyle(
            color: Colors.white
          ),),
        ),
      );
                    }).toList(),
                  ),
                );
              }),
            ),
      
           
          ],
        ),
         Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: screenHeight * 0.1 - 30,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Send Message',
                            enabledBorder: OutlineInputBorder(), 
                            focusedBorder: OutlineInputBorder()
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){ 
                      onSendmessages(); 
                    message.dispose();
                    }, icon: Icon(Icons.send))
                  ],
                ),
              ),
            )
        ]
      )
      
      ),
    );
  }
 
}