import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/controllers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String whoisLogin = 'patient';
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _insurance_companyController =TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _doctorIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Color.fromARGB(255, 116, 168, 210),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Asset/images/hospital.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: whoisLogin == 'hospital'
                                ? Colors.grey
                                : const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin = 'hospital';
                            });
                          },
                          child: const Text(
                            'Hospital',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          )),
                      const Gap(30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: whoisLogin == 'patient'
                                ? Colors.grey
                                : const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin = 'patient';
                            });
                          },
                          child: const Text('Patient',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0))),
                      const Gap(30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: whoisLogin == 'insurance'
                                ? Colors.grey
                                : const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin = 'insurance';
                            });
                          },
                          child: const Text('Insurance',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0)))
                    ],
                  ),
                  const Gap(22.0),
                  TextFormField(
                    controller: whoisLogin == 'patient'
                        ? _patientController
                        : whoisLogin == 'hospital'
                            ? _hospitalController
                            : _insurance_companyController,
                    decoration: InputDecoration(
                      labelText: whoisLogin == 'patient'
                          ? 'Patient ID'
                          : whoisLogin == 'hospital'
                              ? 'Hospital ID'
                              : 'Insurance Company ID',
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.0)),
                      fillColor: const Color.fromARGB(255, 193, 129, 129),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      filled: true,
                    ),
                  ),
                  Gap(25.0),
                  whoisLogin == 'hospital'
                      ? Column(
                          children: [
                            TextFormField(
                              controller: _departmentController,
                              decoration: InputDecoration(
                                labelText: 'Department Id',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0)),
                                fillColor:
                                    const Color.fromARGB(255, 193, 129, 129),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                filled: true,
                              ),
                            ),
                            Gap(25.0),
                            TextFormField(
                              controller: _doctorIdController,
                              decoration: InputDecoration(
                                labelText: 'Doctor Id',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0)),
                                fillColor:
                                    const Color.fromARGB(255, 193, 129, 129),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                filled: true,
                              ),
                            ),
                            Gap(25.0),
                          ],
                        )
                      : Container(),
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      fillColor: const Color.fromARGB(255, 193, 129, 129),
                      filled: true,
                    ),
                  ),
                  const Gap(50.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 91, 30, 26),
                          padding: const EdgeInsets.all(14.0),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          if (whoisLogin == 'patient') {
                            Auth.instance.login(
                                _patientController.text, _cvvController.text);
                          } else if (whoisLogin == 'hospital') {
                            Auth.instance.loginDoctor(
                                _hospitalController.text,
                                _departmentController.text,
                                _doctorIdController.text,
                                _cvvController.text);
                          } else {
                            Auth.instance.loginInsurance(
                                _insurance_companyController.text,
                                _cvvController.text);
                          }
                        },
                        child: const Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0))),
                  ),
                  const Gap(15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot password? ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Get it on Email!',
                            style: TextStyle(
                                color: Color.fromARGB(255, 91, 30, 26),
                                fontSize: 17.0),
                          ))
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
