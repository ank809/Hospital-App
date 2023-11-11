import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Patient_Details {
  
  static Stream<QuerySnapshot> fetchdata(String card_no, String cvv) {
    return FirebaseFirestore.instance
        .collection('patient_details')
        .where('card_no', isEqualTo: card_no)
        .where('cvv', isEqualTo: cvv)
        .snapshots();
  }

  static void updatePrescription(String docID, String prescriptionText) {
    if (prescriptionText.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('patient_details')
          .doc(docID)
          .update({
        'prescription': FieldValue.arrayUnion([prescriptionText])
      });
      Get.snackbar('Prescription Updated', '');
    }
  }

  // update data
  static void  update_details(String card_no, String imagepath) async{
    CollectionReference reference = FirebaseFirestore.instance.collection('patient_details');
    // get the data of all where the condition is being satisfied
    QuerySnapshot snapshot = await reference.where('card_no', isEqualTo: card_no).get();
    if(snapshot.docs.isNotEmpty) {
        DocumentReference ref = snapshot.docs[0].reference;
        await ref.update({'reports' :  FieldValue.arrayUnion([imagepath])}).then((value) {
          Get.snackbar('Updated', 'Successfully updated');
        });
    } 
    else {
      log('Document Empty');
    }
  }
}
