import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodgroups=['A+','A-','O+','O-','AB+','AB-'];
  String? selectbldgrp;
  final CollectionReference donor=FirebaseFirestore.instance.collection('donor');
  TextEditingController donorname=TextEditingController();
  TextEditingController phoneno=TextEditingController();
  void addDonor(){
      final data ={'name':donorname.text,'phone':phoneno.text,'group':selectbldgrp};
      donor.add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('ADD DONORS'),
      backgroundColor: Colors.red, 
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label:Text("Donor Name"),
                      ),
                    ),
            ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: phoneno,
             keyboardType:TextInputType.number,
             maxLength: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label:Text("Phone Number"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration:const InputDecoration(label:Text("Select Blood Group")),
            items: bloodgroups.map((e)=>DropdownMenuItem(
            value: e,
            child:Text(e),))
            .toList(),
             onChanged: (val){
              selectbldgrp=val;
             }),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: (){
             if(donorname.text.isNotEmpty&&phoneno.text.isNotEmpty&&selectbldgrp!=null){
            addDonor();
            Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.red)
          ),
         child: const Text("Submit",
         style:TextStyle(fontSize: 20) ,)
           )
      ],
      )
      ),
    );
  }
}