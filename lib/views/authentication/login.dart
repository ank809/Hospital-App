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
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _patientController = TextEditingController();
  TextEditingController _insurance_companyController = TextEditingController();
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
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Asset/images/hospital.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Gap(12),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:whoisLogin=='hospital'?Colors.grey:
                                const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin='hospital';
                            });
                          },
                          child: const Text(
                            'Hospital',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          )),
                      Gap(30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:whoisLogin=='patient'?Colors.grey:
                                const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin='patient';
                            });
                          },
                          child: const Text('Patient',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0))),
                      Gap(30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:whoisLogin=='insurance'?Colors.grey:
                                const Color.fromARGB(255, 91, 30, 26),
                            padding: const EdgeInsets.all(18.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              whoisLogin='insurance';
                            });
                          },
                          child: const Text('Insurance',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0)))
                    ],
                  ),
                  Gap(22.0),
                  TextFormField(
                    controller: whoisLogin=='patient'? _patientController: whoisLogin=='hospital'?_hospitalController: _insurance_companyController ,
                    decoration: InputDecoration(
                      labelText: whoisLogin=='patient'? 'Patient ID': whoisLogin=='hospital'?'Hospital ID': 'Insurance Company ID',
                      labelStyle:TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.0)),
                      fillColor: Color.fromARGB(255, 193, 129, 129),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      filled: true,
                    ),
                  ),
                  Gap(25.0),
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelStyle:TextStyle(color: Colors.black),
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      fillColor: Color.fromARGB(255, 193, 129, 129),
                      filled: true,
                    ),
                  ),
                  const Gap(50.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 91, 30, 26),
                          padding: const EdgeInsets.all(14.0),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          if(whoisLogin=='patient'){
                          Auth.instance.login(_patientController.text, _cvvController.text);
                          }
                        },
                        child: const Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0))),
                  ),
                  Gap(15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Forgot password? ', style: TextStyle(fontSize: 17.0),),
                      TextButton(onPressed: (){}, child: Text('Get it on Email!', style: TextStyle(color:  const Color.fromARGB(255, 91, 30, 26), fontSize: 17.0 ),))
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
