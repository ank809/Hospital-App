import 'package:flutter/material.dart';
import 'package:hospital_app/views/screens/home.dart';
import 'package:hospital_app/views/screens/medicines.dart';
import 'package:hospital_app/views/screens/reports.dart';
import 'package:hospital_app/views/screens/upload.dart';
class MainScreen extends StatefulWidget {
  final bool isPatient;
  final String card_no;
  final String cvv;
  const MainScreen(
      {required this.card_no,
      required this.cvv,
      required this.isPatient,
      super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      HomePage(card_no: widget.card_no, cvv: widget.cvv, isPatient: widget.isPatient),
      const MedicinesPage(),
     const ReportsPage(),
      const UploadReports()
      // Add other screens as needed
    ];
  }
  int _currentindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              _currentindex=index;
            });
          },
          iconSize: 30.0,
          selectedFontSize: 19.0,
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: const Color.fromARGB(255, 170, 147, 150),
          unselectedFontSize: 16.0,
          backgroundColor: const Color.fromARGB(255, 139, 45, 39), 
          currentIndex: _currentindex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication_liquid_outlined),
              label: 'Medicines',
            ),
            BottomNavigationBarItem(
             icon: Icon(Icons.note_add_sharp),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload_file_outlined),
              label: 'Upload ',
            ),
          ],
          showUnselectedLabels: true,
        ),
    );

  }
}