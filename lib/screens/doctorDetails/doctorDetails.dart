import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import '../../widgets/doctorDropDown.dart';

class Doctordetails extends StatefulWidget {
  const Doctordetails({super.key});

  @override
  _DoctordetailsState createState() => _DoctordetailsState();
}

class _DoctordetailsState extends State<Doctordetails> {
  // List of doctors with image and description
  final Map<String, Map<String, String>> doctorDetails = {
    'Dr. John': {
      'image': 'assets/images/covid-19.png',
      'title': 'Genaral Practiotioner',
      'description': 'Dr. John is a renowned cardiologist with 10 years of experience.',
    },
    'Dr. Jane': {
      'image': 'assets/images/GoogleIcon.png',
      'title': 'Genaral Practiotioner',
      'description': 'Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.Dr. Jane is a pediatrician with a special focus on child health.',
    },
    'Dr. Mike': {
      'image': 'assets/images/dr_mike.png',
      'title': 'Genaral Practiotioner',
      'description': 'Dr. Mike is an orthopedic surgeon with expertise in sports injuries.',
    },
  };

  // Variable to hold the currently selected doctor
  String? _selectedDoctor;

  @override
  void initState() {
    super.initState();
    // Set the first doctor from the map as the selected doctor initially
    _selectedDoctor = doctorDetails.keys.first;
  }

  // Callback to update the selected doctor
  void _handleDoctorSelection(String? selectedDoctor) {
    setState(() {
      _selectedDoctor = selectedDoctor;
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
                doctors: doctorDetails.keys.toList(), // Pass the list of doctor names
                onDoctorSelected: _handleDoctorSelection, // Callback to handle selection
              ),
              const SizedBox(height: 20),
        
              // Display selected doctor details
              if (_selectedDoctor != null)
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
                              child: Image.asset(
                                doctorDetails[_selectedDoctor]!['image']!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover, // Ensures the image covers the circle
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Center(
                          child: Text(
                            doctorDetails[_selectedDoctor]!['title']!,
                            style: const TextStyle(fontSize: 20,),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // Doctor Description
                        Text(
                          doctorDetails[_selectedDoctor]!['description']!,
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
