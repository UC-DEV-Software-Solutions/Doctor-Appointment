import 'package:firebase_testing/services/auth.dart';
import 'package:firebase_testing/widgets/Carosel.dart';
import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../../services/doctorDetails.dart';
import '../../widgets/doctorDropDown.dart';
import '../wrapper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // create a obj from AuthService
  final AuthServices _auth = AuthServices();

  List<String> _doctors = [];
  String? _selectedDoctor;

  // Callback function to handle doctor selection
  void _handleDoctorSelection(String? selectedDoctor) {
    setState(() {
      _selectedDoctor = selectedDoctor;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }
  // Fetch doctors from Firestore and update the dropdown
  Future<void> _fetchDoctors() async {
    try {
      DoctorDetailsService doctorService = DoctorDetailsService();
      final doctorList = await doctorService.getDoctors().first;
      setState(() {
        _doctors = doctorList.map((doc) => doc.dName).toList();
        if (_doctors.isNotEmpty) {
          _selectedDoctor = _doctors.first;
        }
      });
    } catch (error) {
      print("Error fetching doctors: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text("WELCOME",
          style: TextStyle(
          color: bgBlack,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,),
        ),
          actions: [
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  foregroundColor: MaterialStatePropertyAll(bgBlack),
                ),
                onPressed: () async{
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(), // Replace with your SignIn page widget
                ),
              );
            }, child: const Icon(Icons.logout))
          ],
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Carosel('carouselImages'),
                Center(
                    child: Image.asset('assets/images/covid-19.png',
                      height: 400,
                    )
                ) ,
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                      child: Column(
                        children: [
                          DoctorDropdown(
                            doctors: _doctors,
                            onDoctorSelected: _handleDoctorSelection,
                          ),
                        ],
                      ))
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
