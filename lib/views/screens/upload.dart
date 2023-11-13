import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital_app/controllers/insurance.dart';
import 'package:hospital_app/controllers/patient_details.dart';
import 'package:hospital_app/controllers/pick_image.dart';
import 'package:hospital_app/controllers/upload_image.dart';

class UploadDetails extends StatefulWidget {
  final String cardno;
  final bool isPatient;
  const UploadDetails({required this.cardno, required this.isPatient, Key? key});

  @override
  _UploadDetailsState createState() => _UploadDetailsState();
}

class _UploadDetailsState extends State<UploadDetails> {
  File? imgpath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 173, 58, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 20),
              child: imgpath != null
                  ? Image.file(
                      imgpath!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: InkWell(
                        onTap: () async {
                          final newimgpath = await Pick_Image.pickFile();
                          if (newimgpath != null) {
                            setState(() {
                              imgpath = File(newimgpath.path);
                            });
                          }
                        },
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 45,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 50.0,
              width: 150.0,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () async {
                    if (imgpath != null) {
                      log(imgpath.toString());
                      String? downurl = await UploadImages.upload_images(
                          widget.cardno, imgpath!.path);
                      if (downurl != null) {
                        if(widget.isPatient){
                          Update_Insurance.upload_image(widget.cardno, downurl, false);
                          setState(() {
                            imgpath=null;
                          });
                        }
                       else{
                        Patient_Details.update_details(widget.cardno, downurl);
                        
                       }
                      }
                    }
                  },
                  child: const Text(
                    'Upload',
                    style: TextStyle(fontSize: 20.0, color: Colors.pink),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
