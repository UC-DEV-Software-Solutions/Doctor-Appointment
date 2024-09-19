import 'package:firebase_testing/widgets/doctorDropDown.dart';
import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../services/appointment.dart';
import '../../widgets/paymentSelectionDialog.dart';
import '../../widgets/previousAppointments.dart';
import '../../widgets/textField.dart';

class Makeappointment extends StatefulWidget {
  @override
  State<Makeappointment> createState() => _MakeappointmentState();
}

class _MakeappointmentState extends State<Makeappointment> {
  // const Makeappointment({super.key});
  final List<String> _doctors = ['Dr. Mahesh', 'Dr. Supun', 'Dr. Nioshani'];

  // This will store the selected doctor
  String? _selectedDoctor;

  // Callback function to handle doctor selection
  void _handleDoctorSelection(String? selectedDoctor) {
    setState(() {
      _selectedDoctor = selectedDoctor;
    });
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentSelectionDialog(
          onPaymentOptionSelected: (selectedOption) {
            // Handle selected payment option
            print("Selected Payment Method: $selectedOption");
          },
        );
      },
    );
  }


// Function from ChatGPT
  Future<void> _saveAppointmentToFirestore(BuildContext context) async {
    try {
      // Replace with your Firestore collection and document structure
      // await FirebaseFirestore.instance.collection('appointments').add({
      //   'doctorName': _doctorNameController.text,
      //   'patientName': _patientNameController.text,
      //   'appointmentDate': appointmentDate,
      //   'createdAt': FieldValue.serverTimestamp(),
      // });

      // Open the payment selection dialog after saving data
      _showPaymentDialog(context);
    } catch (error) {
      print('Failed to save appointment: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to make an appointment. Please try again.')),
      );
    }
  }

  // Controllers for TextFields
  final TextEditingController _patientNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _reasonController = TextEditingController();

  final TextEditingController _doctorNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ageController.dispose();
    _patientNameController.dispose();
    _phoneNumberController.dispose();
    _reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<String> previousAppointments = [
      'Appointment on 2024-09-01 with Dr. John',
      'Appointment on 2024-08-15 with Dr. Jane',
      'Appointment on 2024-08-10 with Dr. Mike',
    ];

    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text('Make Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Section
              const Text(
                'Select Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Placeholder for a Calendar widget, replace it with any actual calendar package widget
              CalendarDatePicker(

                initialDate: DateTime.now(), // The current date as the initial selection
                firstDate: DateTime(2000), // The earliest date that can be selected
                lastDate: DateTime(2100),  // The latest date that can be selected
                onDateChanged: (DateTime selectedDate) {
                  // Handle the date selection
                  print("Selected date: $selectedDate");
                },
              ),

              const SizedBox(height: 10),

              DoctorDropdown(
                doctors: _doctors,
                onDoctorSelected: _handleDoctorSelection, // Callback for selection
              ),
              const SizedBox(height: 20),

              // Display the selected doctor
              Text(
                _selectedDoctor == null
                    ? "No doctor selected"
                    : "Selected Doctor: $_selectedDoctor",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Patient Details Form
              const Text(
                'Patient Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(child: Column(
                children: [
                  TextInputField(
                      controller: _patientNameController,
                      hintText: "Full Name *",
                      inputKeyboardType: TextInputType.text,
                      isPassword: false
                  ),
                  const SizedBox(height: 20,),
                  TextInputField(
                      controller: _phoneNumberController,
                      hintText: "Phone Number *",
                      inputKeyboardType: TextInputType.number,
                      isPassword: false
                  ),
                  const SizedBox(height: 20,),
                  TextInputField(
                      controller: _ageController,
                      hintText: "Age *",
                      inputKeyboardType: TextInputType.number,
                      isPassword: false
                  ),
                  const SizedBox(height: 20,),
                  TextInputField(
                      controller: _reasonController,
                      hintText: "Symptoms/Reason for Appointment",
                      inputKeyboardType: TextInputType.text,
                      isPassword: false
                  ),
                ],
              )),
              const SizedBox(height: 20),

              // Make Appointment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(bgBlack),
                  ),
                  onPressed: () async{

                    await AppointmentService().addAppointment(_patientNameController.text, _phoneNumberController.text,int.parse(_ageController.text), _reasonController.text);
                    _patientNameController.clear();
                    _phoneNumberController.clear();
                    _ageController.clear();
                    _reasonController.clear();

                    // Save data to Firestore and open the payment dialog
                    // _saveAppointmentToFirestore(context);
                  },
                  child: const Text('Make Appointment'),
                ),
              ),
              const SizedBox(height: 20),

              // Previous Appointments List
              const Text(
                'Previous Appointments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(padding: const EdgeInsets.all(16.0),
                child: PreviousAppointments(previousAppointments: previousAppointments),)
            ],
          ),
        ),
      ),
    );
  }
}
