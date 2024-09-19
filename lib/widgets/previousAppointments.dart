import 'package:flutter/material.dart';
import 'package:firebase_testing/models/appointmentModel.dart';

class PreviousAppointments extends StatelessWidget {
  final List<AppointmentModel> previousAppointments;

  const PreviousAppointments({super.key, required this.previousAppointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView inside a ScrollView or small container
      itemCount: previousAppointments.length,
      itemBuilder: (context, index) {
        final appointment = previousAppointments[index]; // Access each AppointmentModel
        return Card(
          child: ListTile(
            title: Text(appointment.patientName), // Display patient's name
            subtitle: Text(
              'Phone: ${appointment.phoneNumber}\nAge: ${appointment.age}\nReason: ${appointment.reason}\nBooked On: ${appointment.createdAt}',
            ), // Display additional details like phone, age, and reason
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
