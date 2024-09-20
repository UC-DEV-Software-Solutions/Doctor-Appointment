import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import '../../models/doctorModel.dart';
import '../../services/doctorDetails.dart';
import '../../widgets/doctorDropDown.dart';

class Doctordetails extends StatefulWidget {
  const Doctordetails({super.key});

  @override
  _DoctordetailsState createState() => _DoctordetailsState();
}

class _DoctordetailsState extends State<Doctordetails> {
  List<DoctorModel> _doctors = [];
  DoctorModel? _selectedDoctorDetails; // Variable to hold the selected doctor's details

  // Fetch doctors from Firestore and update the dropdown
  Future<void> _fetchDoctors() async {
    try {
      DoctorDetailsService doctorService = DoctorDetailsService();
      // Using StreamBuilder for real-time updates
      doctorService.getDoctors().listen((doctorList) {
        setState(() {
          _doctors = doctorList; // Get list of doctor models
          // Automatically set the first doctor as the selected one
          if (_doctors.isNotEmpty) {
            _selectedDoctorDetails = _doctors.first; // Set first doctor as the selected one
          }
        });
      });
    } catch (error) {
      print("Error fetching doctors: $error");
    }
  }

  // Variable to hold the currently selected doctor's name
  String? _selectedDoctorName;

  @override
  void initState() {
    super.initState();
    _fetchDoctors(); // Fetch doctors when the widget initializes
  }

  // Callback to update the selected doctor
  void _handleDoctorSelection(String? selectedDoctorName) {
    setState(() {
      _selectedDoctorName = selectedDoctorName;
      // Find and update the selected doctor's details
      _selectedDoctorDetails = _doctors.firstWhere((doc) => doc.dName == selectedDoctorName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(title: const Text('Doctor Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor dropdown
              DoctorDropdown(
                doctors: _doctors.map((doctor) => doctor.dName).toList(), // Pass the list of doctor names dynamically
                onDoctorSelected: _handleDoctorSelection, // Callback to handle selection
              ),
              const SizedBox(height: 20),

              // Display selected doctor details
              if (_selectedDoctorDetails != null)
                Container(
                  decoration: BoxDecoration(
                    color: mainBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor Image
                        Center(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.network(
                                _selectedDoctorDetails?.doctorPic ?? 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Use doctorPic from Firestore
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover, // Ensures the image covers the circle
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error), // Fallback for any error in image loading
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Center(
                          child: Text(
                            _selectedDoctorDetails!.dtitle, // Use title from Firestore
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // Doctor Description
                        Text(
                          _selectedDoctorDetails!.dDescription, // Use description from Firestore
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Text("No doctor selected", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
