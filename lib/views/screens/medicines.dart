import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MedicinesPage extends StatefulWidget {
  final String card_no;
  final bool isPatient;
  const MedicinesPage({required this.card_no, required this.isPatient,  super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medicines'), backgroundColor: const Color.fromARGB(255, 120, 43, 38),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child:  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('medicines').snapshots(),
          builder: (context, snapshot) {
           if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var medicine= snapshot.data!.docs;
          return ListView.builder(
            itemCount: medicine.length,
            itemBuilder: (context, index){
              var medicines= medicine[index];
              var medicineData= medicines.data() as Map<String, dynamic>;
              String md = medicineData['no_of_days'][index].toString();
              String f= medicineData['frequency'][index].toString();
              String mname= medicineData['medicine_name'][index].toString();
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text('Medicine Name: ${mname}'),
                //  title: Text(medicineData['medicine_name'].toString() ) ,
                  subtitle: Text('Days: ${md}, Frequency: ${f}'),
                ),
              );
            });
        },)
      ),
      floatingActionButton:  widget.isPatient?null:FloatingActionButton(onPressed: (){
        _showAddMedicineDialog(context);
      }, child: Icon(Icons.add, ),
      backgroundColor: const Color.fromARGB(255, 120, 43, 38),),
    );
  }
   void _showAddMedicineDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Medicine',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Medicine Name',
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.0)),
                
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Number of Days',
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.0)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Frequency per Day',
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.0)),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 120, 43, 38)),
                onPressed: () {
                  // TODO: Add your logic to save the medicine details
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Done'),
              ),
            ],
          ),
        );
      },
    );
   }
}