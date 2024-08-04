import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
 //ignore: unused_import
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference donor=FirebaseFirestore.instance.collection('donor');
  void deleteDonor(docId){
    donor.doc(docId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text('Blood Donation App'),
        backgroundColor: Colors.red, 
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.pushNamed(context, '/add');
        },
          backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          size:40
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder(
          stream:donor.orderBy('name').snapshots(),
          builder:(context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:(context, index) {
                  final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                  return  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 2.0),
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: SizedBox(
                        height:80,
                        child: Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          elevation: 4,
                          child:ListTile(                   
                          leading:CircleAvatar(
                           radius:30,
                           foregroundColor: Colors.white,
                           backgroundColor: Colors.redAccent,
                           child:Text(
                            donorSnap['group'],
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                          ),       
                         title: Text(donorSnap['name'],
                         style: const TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 20),
                         ),
                         subtitle: Text(
                          donorSnap['phone'].toString(),
                          style: const TextStyle(fontSize: 16),
                         ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed:(){
                             Navigator.pushNamed(context,'/update',
                            arguments: {
                                 'name':donorSnap['name'],
                                 'phone':donorSnap['phone'].toString(),
                                 'group':donorSnap['group'],
                                 'id':donorSnap.id,
                              });
                            }, icon: const Icon(Icons.edit),iconSize: 30,color: Colors.blue,),
                            IconButton(onPressed:(){ 
                              deleteDonor(donorSnap.id);
                            }, 
                            icon: const Icon(Icons.delete),iconSize: 30,color: Colors.red,)
                          ],
                        ),
                      ),
                      ),),
                    ),
                  );
                }
                );
            }
            return Container();
          },
         ),
      );
  }
}