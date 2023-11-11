import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/controllers/insurance.dart';
import 'package:hospital_app/controllers/patient_details.dart';

class CompanyScreen extends StatefulWidget {
  final bool isPatient;
  final bool isDoctor;
  const CompanyScreen({ required this.isDoctor,  required this.isPatient, super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unapproved data'), backgroundColor: Color.fromARGB(255, 203, 47, 99),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: StreamBuilder<QuerySnapshot>(
          stream: Update_Insurance.getdata(),
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
                      style: TextStyle(color: Colors.white)));
            }
            widget.isDoctor?print('Doctor',):print('Patient');
            List<DocumentSnapshot> document = snapshot.data!.docs;
            return ListView.builder(
                itemCount: document.length,
                itemBuilder: (context, index) {
                  final item = document[index].data() as Map<String, dynamic>;
                  return Card(
                     margin: EdgeInsets.all(15.0),
                    color: Color.fromARGB(255, 203, 47, 99),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Patient\'s Card no:  ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item['card_no'],
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image.network(
                              item['imageURL'],
                              fit: BoxFit.contain,
                            ),
                          ),
                           widget.isPatient? Row(): Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                  onPressed: () {
                                    // nothing
                                    Update_Insurance.deletedata(
                                        document[index].id);
                                  },
                                  child: Text('Decline', style: TextStyle(color: Colors.pink),)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                  onPressed: () {
                                    Update_Insurance.update_data(
                                        item['card_no'], document[index].id);
                                    Patient_Details.update_details(
                                        item['card_no'], item['imageURL']);
                                    // Update_Insurance.deletedata(
                                    //     document[index].id);
                                  },
                                  child: Text('Accept',  style: TextStyle(color: Colors.pink)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
