import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadImages{
  static Future<String?> upload_images(String cardno, String imgpath) async{
    final file= File(imgpath);
    String filename= basename(file.path);
    final Reference storageref= FirebaseStorage.instance.ref().child('Patients/$cardno/$filename');
    final UploadTask upload= storageref.putFile(file);
    String? downurl;
     await upload.whenComplete(() async{
      final downloadurl= await storageref.getDownloadURL();
      downurl=downloadurl;
    });
    return downurl;

  }
}