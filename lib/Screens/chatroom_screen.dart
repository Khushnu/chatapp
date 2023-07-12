// ignore_for_file: must_be_immutable

import 'package:chatapp/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreem extends StatelessWidget {
  ChatRoomScreem( {super.key, required this.chatroomId,required this.usermap, this.chatsUi});
  Map<String, dynamic> usermap;
   final String chatroomId;
   final chatsUi;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final  _message = TextEditingController();
//  getMessage(){
//   print(chatroomId);
//  Stream<QuerySnapshot> _chatSnap=FirebaseFirestore.instance.collection('chatroom')
//                 .doc().collection('chats').snapshots();
// return _chatSnap;
//  }
 
  void onSendmessages() async{ 
     if(_message.text.isNotEmpty){
       Map<String, dynamic> messages = {
      'sendby' : firebaseAuth.currentUser!.displayName, 
      'message' : _message.text, 
      'time' : FieldValue.serverTimestamp()
     };
     
    await firebaseFirestore.collection('chatroom')
    .add(messages);
    _message.clear();
     } else {
      print('data saved');
        print('enter some text');
     }
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
                stream: firebaseFirestore.collection('chatroom')
                .orderBy("time", descending: false).snapshots(),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return const Center(child: Text('Start You New Chat'),);
                } 
                print(snapshot.data!.docs);
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) 
                    {
                      var d = documentSnapshot.data() as Map<String, dynamic>; 
                      return Column(
                        children: [
                          Container(
                           // height: 100,
        width: screenWidth, 
        alignment: d['sendby'] == firebaseAuth.currentUser!.displayName ? 
        Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14), 
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8), 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color:d['sendby'] == firebaseAuth.currentUser!.displayName
             ? Colors.grey.shade400 : Colors.blue
          ), 
          child: Text(d['message'].toString(), style: const TextStyle(
            color: Colors.white
          ),),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
           alignment: d['sendby'] == firebaseAuth.currentUser!.displayName ? 
          Alignment.centerRight : Alignment.centerLeft,
           child: Text("${d['sendby'] == firebaseAuth.currentUser!.displayName ? 'You' : firebaseAuth.currentUser!.displayName}")),
      )
                        ],
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
                          controller: _message,
                          decoration: const InputDecoration(
                            hintText: 'Send Message',
                            enabledBorder: OutlineInputBorder(), 
                            focusedBorder: OutlineInputBorder()
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: onSendmessages, icon: const Icon(Icons.send))
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