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
}
