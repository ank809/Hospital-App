import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/controllers/patient_details.dart';
import 'package:hospital_app/views/screens/insurance_company.dart';
class ReportsPage extends StatefulWidget {
  final  String card_no;
  final String cvv;
  final bool isPatient;
  const ReportsPage({required this.card_no, required this.cvv,  required this.isPatient,  super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Your reports'), backgroundColor: const Color.fromARGB(255, 173, 58, 50),
      actions: [
        IconButton(onPressed: (){
          Get.to(CompanyScreen(isPatient: widget.isPatient));
        }, icon: Icon(Icons.info))
      ],),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: Patient_Details.fetchdata(widget.card_no, widget.cvv),
         builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data found',
                      style: TextStyle(color: Colors.white)),
                );
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white)));
              }
              List<DocumentSnapshot> document = snapshot.data!.docs;
              return ListView.builder(
                itemCount: document.length,
                itemBuilder:(context, index){
                  var item= document[index].data() as Map<String , dynamic>;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(15.0),
                    child: item['reports'] == "none"
                                ? const Text('No reports')
                                : Column(
                                    children: item['reports']
                                        .map<Widget>((imageUrl) {
                                      return Container(
                                        height:
                                            550, // Increase the height for larger images
                                        width: double
                                            .infinity, // Set the width to fill the screen
                                        // margin: const EdgeInsets.only(
                                        //     bottom:
                                        //         5.0), // Add spacing between images
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit
                                              .contain, // Adjust the fit to cover the entire container
                                        ),
                                      );
                                    }).toList(),
                                  ),
                  );
                } );
         },),
      ),
    );
  }
}