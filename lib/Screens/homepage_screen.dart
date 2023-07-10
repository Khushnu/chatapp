import 'package:chatapp/Constants/helperfunctions.dart';
import 'package:chatapp/Screens/chatroom_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  
   Map<String, dynamic> userMap = <String, dynamic>{};

  final search = TextEditingController();
  Future<void> onSearch() async { 
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; 

    await firebaseFirestore.collection('users')
    .where("email", isEqualTo: search.text)
    .get()
    .then((value) {
      setState(() {
         userMap = value.docs[0].data();
      });
     
    }); 
  }



  String chatroomId(String user1, String user2){
    if(user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]){
      return '$user1$user2';
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              IconButton(onPressed: (){ 
                HelperFunction.logOut(context);
              }, icon: const Icon(Icons.logout)), 
              Expanded(
                child: TextFormField(
                  controller: search,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), 
                    prefixIconColor: Colors.red,
                    labelText: 'Search', 
                    labelStyle: TextStyle(color: Colors.red),
                    enabledBorder:  OutlineInputBorder(
                                  
                                  borderSide: BorderSide(
                                    color: Colors.red, 
                                    width: 1.5
                                  )
                                ), 
                                errorBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, 
                                    width: 1.5
                                  )
                                ), 
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, 
                                    width: 1.5
                                  )
                                ),  
                  ),
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search))
            ],
          ), 
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('user').where('uid' , isNotEqualTo: FirebaseAuth.instance.currentUser!.uid ).snapshots(),
            builder: (_, snapshot){
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              } 
              return   SingleChildScrollView(
                child: Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                    return   ListTile(
                        title: Text(data['name'],),
                        leading: const Icon(Icons.person), 
                        subtitle: Text(data['email']), 
                        trailing: InkWell(
                          onTap: () {
                            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                             String chatrooID =  chatroomId(firebaseAuth.currentUser!.displayName ?? "" , data['name']);
                           
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatRoomScreem(chatroomId: chatrooID, usermap: data,)));},
                          child: const Icon(Icons.chat)),
                      );
                  }).toList(),
                ),
              );
             
          })
        ],),
      )),
    );
  }
}