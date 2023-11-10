import 'package:flutter/material.dart';
class UploadReports extends StatefulWidget {
  const UploadReports({super.key});

  @override
  State<UploadReports> createState() => _UploadReportsState();
}

class _UploadReportsState extends State<UploadReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      color: Colors.yellow,
      ),
    );
    }
}