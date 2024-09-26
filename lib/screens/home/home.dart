import 'package:firebase_testing/screens/home/chatBotScreen.dart';
import 'package:firebase_testing/services/auth.dart';
import 'package:firebase_testing/widgets/Carosel.dart';
import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../models/appointmentModel.dart';
import '../../services/appointment.dart';
import '../../services/doctorDetails.dart';
import '../../widgets/appointmentGridView.dart';
import '../../widgets/doctorDropDown.dart';
import '../wrapper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
  List<String> _doctors = [];
  String? _selectedDoctor;
  final AppointmentService _appointmentService = AppointmentService();
  Stream<List<AppointmentModel>>? appointmentsStream;

  // Fetch doctors from Firestore and update the dropdown
  Future<void> _fetchDoctors() async {
    try {
      DoctorDetailsService doctorService = DoctorDetailsService();
      final doctorList = await doctorService.getDoctors().first;
      setState(() {
        _doctors = doctorList.map((doc) => doc.dName).toList();
        if (_doctors.isNotEmpty) {
          _selectedDoctor = _doctors.first;

          // Fetch appointments for the first doctor
          appointmentsStream = _appointmentService.getAppointmentsForSelectedDay(
            doctorName: _selectedDoctor!,
            selectedDate: DateTime.now(),
          );
        }
      });
    } catch (error) {
      print("Error fetching doctors: $error");
    }
  }
  // Callback function to handle doctor selection
  void _handleDoctorSelection(String? selectedDoctor) {
    setState(() {
      _selectedDoctor = selectedDoctor;
      if (selectedDoctor != null) {
        appointmentsStream = _appointmentService.getAppointmentsForSelectedDay(
          doctorName: selectedDoctor,
          selectedDate: DateTime.now(),
        );
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "WELCOME",
            style: TextStyle(
              color: bgBlack,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
                foregroundColor: WidgetStatePropertyAll(bgBlack),
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wrapper(), // Replace with your SignIn page widget
                  ),
                );
              },
              child: const Icon(Icons.logout),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Carosel('carouselImages'),
                Center(
                  child: Image.asset(
                    'assets/icon/icon.png',
                    height: 400,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    child: Column(
                      children: [
                        DoctorDropdown(
                          doctors: _doctors,
                          onDoctorSelected: _handleDoctorSelection,
                            selectedDoctor: _selectedDoctor
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              appointmentsStream != null
                  ? StreamBuilder<List<AppointmentModel>>(
                stream: appointmentsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<AppointmentModel> appointments = snapshot.data!;
                    return AppointmentGridView(appointments: appointments);
                  } else {
                    return const Center(child: Text("No appointments found for today."));
                  }
                },
              )
                  : const Center(child: Text("Please select a doctor.")),
                
                ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChatBotscreen(),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/icon/icon.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position at bottom-right
      ),
    );
  }
}
