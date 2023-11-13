import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/screens/home.dart';
import 'package:hospital_app/views/screens/main_screen.dart';

class SearchPatient extends StatefulWidget {
  const SearchPatient({super.key});

  @override
  State<SearchPatient> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  final _cardController = TextEditingController();
  final _cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Patient'), centerTitle: true, backgroundColor: const Color.fromARGB(255, 104, 33, 28),),
      body: Container(
        margin: EdgeInsets.all(35.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _cardController,
              decoration: const InputDecoration(
                labelText: 'Enter patient card number',
                focusedBorder: UnderlineInputBorder(
                ),
                focusColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            Gap(25.0),
            TextFormField(
              controller: _cvvController,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(),
                labelText: 'Enter patient card number',
                focusColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            Gap(25.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                        backgroundColor: const Color.fromARGB(255, 114, 47, 43)),
                onPressed: () {
                  Get.to(MainScreen(
                      card_no: _cardController.text,
                      cvv: _cvvController.text,
                      isPatient: false));
                },
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 20.0),
                ))
          ],
        ),
      ),
    );
  }
}
