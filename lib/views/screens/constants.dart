import 'package:flutter/material.dart';
Widget buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 173, 58, 50)),
        const SizedBox(width: 10.0),
        Text('$label: ',
            style: const TextStyle(
                color: Color.fromARGB(255, 139, 45, 39),
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

   Widget buildPrescriptionCard(int index, String prescription) {
    return SizedBox(
      //color: Colors.grey,
      width: double.infinity,
      child: Card(
        color: Color.fromARGB(255, 139, 45, 39),
        elevation: 2,
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prescription,
                style: const TextStyle(fontSize: 19.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  