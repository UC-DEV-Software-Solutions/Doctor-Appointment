import 'package:firebase_testing/services/appointment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_testing/models/appointmentModel.dart';

import '../utils/constants.dart';

class PreviousAppointments extends StatelessWidget {
  final List<AppointmentModel> previousAppointments;

  const PreviousAppointments({super.key, required this.previousAppointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView inside a ScrollView or small container
      physics: const NeverScrollableScrollPhysics(), // Prevents it from being independently scrollable
      itemCount: previousAppointments.length,
      itemBuilder: (context, index) {
        final appointment = previousAppointments[index]; // Access each AppointmentModel
        return Card(
          child: ListTile(
            title: Text(appointment.patientName), // Display patient's name
            subtitle: Text(
              'Phone: ${appointment.phoneNumber}\nAge: ${appointment.age}\nReason: ${appointment.reason}\nBooked On: ${appointment.createdAt}\nDoctor: ${appointment.doctorName}\nDate: ${getFormattedDate(appointment.selectedDate)}\nAppointment Number: ${appointment.appointmentNumber}',
            ), // Display additional details like phone, age, and reason
            trailing: IconButton(
                onPressed: () async{
                  print('Attempting to delete appointment with ID: ${appointment.aId}');
                  AppointmentService().deleteAppointment(appointment.aId);
                },
                icon: const Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}
