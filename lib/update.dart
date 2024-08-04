import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodgroups=['A+','A-','O+','O-','AB+','AB-'];
  String? selectbldgrp;
  final CollectionReference donor=FirebaseFirestore.instance.collection('donor');
   TextEditingController donorname=TextEditingController();
  TextEditingController phoneno=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map;
    donorname.text=args['name'];
    phoneno.text=args['phone'];
    selectbldgrp=args['group'];
    final docId=args['id'];
    void updateDonor(docId){
      final data={
        'name':donorname.text,
        'phone':phoneno.text,
        'group':selectbldgrp
      };
      donor.doc(docId).update(data);
    }
    return Scaffold(
      appBar: AppBar(title:const Text('UPDATE DONOR Info'),
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
            value:selectbldgrp ,
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
              updateDonor(docId);
              Navigator.of(context).pop();
            }
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.red)
          ),
         child: const Text("Update",
         style:TextStyle(fontSize: 20) ,)
           )
      ],
      )
      ),
    );
  }
}