import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hospital_app/model/data.dart';

class Update_Insurance{
  
 // creating a collection 
 static  void upload_image(String card_no, String imageurl, bool isVerified){
    try{
      if(card_no.isNotEmpty && imageurl.isNotEmpty){
        Data data= Data(cardno: card_no, imgurl: imageurl, isVerified: isVerified);
        FirebaseFirestore.instance.collection('insurance_company_data').doc().set(data.toJson()).then((value) {
          Get.snackbar('Image sent', 'Image sent for verification');
        });
      }
    }catch(e){
     Get.snackbar('Error',  e.toString());
    }
  }

  // fetching the data
  static Stream<QuerySnapshot> getdata(){
    return FirebaseFirestore.instance.collection('insurance_company_data').snapshots();
  }

  // update the data
  static void update_data(String cardno, String documentID) async {
    CollectionReference reference= FirebaseFirestore.instance.collection('insurance_company_data');
    // get the data of all where the condition is being satisfied
    QuerySnapshot snapshot = await reference.where('card_no', isEqualTo: cardno).get();
    if(snapshot.docs.isNotEmpty) {
        DocumentReference ref = snapshot.docs[0].reference;
        await ref.update({'isVerified' : true}).then((value) {
          Get.snackbar('Verified', 'Image Verified');
        }).then((value) {
          FirebaseFirestore.instance.collection('insurance_company_data').doc(documentID).delete();
        });
    } 
    else {
      log('Document Empty');
    }
  }
  static deletedata(String documentID){
    FirebaseFirestore.instance.collection('insurance_company_data').doc(documentID).delete().then((value) {
      Get.snackbar('Deleted', 'Image deleted successfully');
    });
  }
  }