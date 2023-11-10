import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/controllers/patient_details.dart';
import 'package:hospital_app/views/screens/constants.dart';

class HomePage extends StatefulWidget {
  final bool isPatient;
  final String card_no;
  final String cvv;
  const HomePage(
      {required this.card_no,
      required this.cvv,
      required this.isPatient,
      super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final TextEditingController prescriptionController = TextEditingController();
    late String doc;
   void _showPrescriptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Prescription'),
        content: TextField(
          controller: prescriptionController,
          decoration: const InputDecoration(
            hintText: 'Enter prescription here',
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            prescriptionController.clear();
          }, child: Text('Cancel')),
          TextButton(
             onPressed: () {
    String prescriptionText = prescriptionController.text;
    // Get the document ID from the snapshot
    String documentId = doc;
    Patient_Details.updatePrescription(documentId, prescriptionText);
    prescriptionController.clear();
    Navigator.of(context).pop();
  },
  child: const Text('Save'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 225, 215, 215),
          child: StreamBuilder<QuerySnapshot>(
            stream: Patient_Details.fetchdata(widget.card_no, widget.cvv),
            builder: (context, snapshot) {
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
                itemBuilder: (context, index) {
                  final item = document[index].data() as Map<String, dynamic>;
                  List<dynamic> prescription = item['prescription'];
                  doc= document[index].id;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.929,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isPatient
                                ? 'Your Details'
                                : 'Patient\'s Details',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          buildDetailRow(Icons.person, 'NAME', item['name']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.calendar_month, 'AGE', item['age']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.card_travel, 'GROUP ID', item['group_id']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.person, 'Gender', item['gender']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.home, 'Address', item['address']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.policy_sharp, 'Policy', item['policy']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(Icons.calendar_month,
                              'Validity(in Years)', item['validity']),
                          const SizedBox(height: 20.0),
                          buildDetailRow(
                              Icons.note_alt_sharp, 'Prescription', ''),
                          for (int i = 0; i < prescription.length; i++)
                            buildPrescriptionCard(i, prescription[i] as String)
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: widget.isPatient
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _showPrescriptionDialog(context);
                },
                backgroundColor: const Color.fromARGB(255, 173, 58, 50),
                child: const Icon(Icons.add),
              ));
  }
}
