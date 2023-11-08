import 'package:cloud_firestore/cloud_firestore.dart';

class Data{
  String cardno;
  String imgurl;
  bool isVerified;
  Data({required this.cardno, required this.imgurl, required this.isVerified});

  // app -> firebase 
  Map<String, dynamic> toJson(){
    return {
      'card_no':cardno,
      'imageURL':imgurl,
      'isVerified':isVerified,
    };
  }

  // firebase to app
  Data fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String, dynamic>;
    return Data(cardno: snapshot['card_no'], imgurl: snapshot['imageURL'], isVerified: snapshot['isVerified']);
  }
}