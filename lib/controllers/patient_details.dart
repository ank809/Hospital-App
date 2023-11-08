import 'package:cloud_firestore/cloud_firestore.dart';

class Patient_Details {
  static Stream<QuerySnapshot> fetchdata(String card_no, String cvv) {
    return FirebaseFirestore.instance
        .collection('patient_details')
        .where('card_no', isEqualTo: card_no)
        .where('cvv', isEqualTo: cvv)
        .snapshots();
  }
}
