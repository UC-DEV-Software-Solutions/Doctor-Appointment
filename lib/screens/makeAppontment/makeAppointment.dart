import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../widgets/previousAppointments.dart';
import '../../widgets/textField.dart';

class Makeappointment extends StatelessWidget {
  // const Makeappointment({super.key});

  // Controllers for TextFields
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();


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

              const SizedBox(height: 20),

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
                      hintText: "Full Name",
                      inputKeyboardType: TextInputType.text,
                      isPassword: false
                  ),
                  const SizedBox(height: 20,),
                  TextInputField(
                      controller: _phoneNumberController,
                      hintText: "Phone Number",
                      inputKeyboardType: TextInputType.number,
                      isPassword: false
                  ),
                  const SizedBox(height: 20,),
                  TextInputField(
                      controller: _ageController,
                      hintText: "Age",
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
                  onPressed: () {
                    // Handle appointment submission
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
