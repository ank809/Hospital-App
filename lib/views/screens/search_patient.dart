import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/screens/home.dart';
import 'package:hospital_app/views/screens/main_screen.dart';
class SearchPatient extends StatefulWidget {
  const SearchPatient({super.key});

  @override
  State<SearchPatient> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  final _cardController= TextEditingController();
  final _cvvController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _cardController,
              decoration: const InputDecoration(
                labelText: 'Enter patient card number',
                
              ),
            ),
            TextFormField(
              controller: _cvvController,
              decoration:const InputDecoration(
                labelText: 'Enter patient card number',
              ),
            ),
            ElevatedButton(onPressed: (){
              Get.to(MainScreen(card_no: _cardController.text, cvv: _cvvController.text, isPatient: false));
            }, child: Text('Search'))
          ],
        ),
      ),
    );
  }
}