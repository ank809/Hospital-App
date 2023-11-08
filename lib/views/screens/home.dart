import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/controllers/patient_details.dart';

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
  //int _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // onTap: (index){
          //   setState(() {
          //     _index=index;
          //   });
          // },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0),
              label: 'Home',
              //  backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication_liquid_outlined, size: 30.0),
              label: 'Medicines',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add_sharp, size: 30.0),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload_file_outlined, size: 30.0),
              label: 'Upload Reports',
            ),
          ],
        ),
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
                  final prescription = item['prescription'] as List<dynamic>;

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
        //   floatingActionButton: SizedBox(
        //   height: 50,
        //   width: 130,
        //   child: FloatingActionButton.extended(
        //     backgroundColor:  Color.fromARGB(255, 212, 71, 61),
        //     onPressed: () {
        //     },
        //     // label: const Row(
        //     //   children: [
        //     //     Icon(
        //     //       Icons.upload_file,
        //     //       size: 30,
        //     //       color: Colors.black,
        //     //     ),
        //     //     Text(
        //     //       'Upload',
        //     //       style: TextStyle(
        //     //           fontSize: 22.0,
        //     //           color: Colors.black,
        //     //           fontWeight: FontWeight.bold),
        //     //     )
        //     //   ],
        //     // ),
        //     label:Icon(Icons.add),
        //   ),
        // ),
        floatingActionButton: widget.isPatient
            ? null
            : FloatingActionButton(
                onPressed: () {},
                backgroundColor: const Color.fromARGB(255, 173, 58, 50),
                child: const Icon(Icons.add),
              ));
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 173, 58, 50)),
        const SizedBox(width: 10.0),
        Text('$label: ',
            style: const TextStyle(
                color: Color.fromARGB(255, 139, 45, 39),
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget buildPrescriptionCard(int index, String prescription) {
    return SizedBox(
      //color: Colors.grey,
      width: double.infinity,
      child: Card(
        color: Color.fromARGB(255, 139, 45, 39),
        elevation: 2,
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prescription,
                style: const TextStyle(fontSize: 19.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
