import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/screens/home.dart';

class Auth extends GetxController{
  static Auth instance= Get.find();

  void login(String card_no, String cvv){
    CollectionReference collectionReference= FirebaseFirestore.instance.collection('patients');
  collectionReference.where('card_no', isEqualTo: card_no).where('cvv', isEqualTo: cvv).get().then((QuerySnapshot snapshot) {
    if(snapshot.docs.isNotEmpty){
      Get.offAll(HomePage(card_no: card_no, cvv: cvv, isPatient: true,));
      Get.snackbar('Successfully Logged in', '');
    }
    else{
      Get.snackbar('Incorrect details', '');
    }
  });
  }
}