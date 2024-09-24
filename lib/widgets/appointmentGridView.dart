import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import '../../models/appointmentModel.dart';

class AppointmentGridView extends StatelessWidget {
  final List<AppointmentModel> appointments;

  const AppointmentGridView({required this.appointments, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort appointments by appointment number in ascending order
    List<AppointmentModel> sortedAppointments = List.from(appointments)..sort((a, b) => a.appointmentNumber.compareTo(b.appointmentNumber));

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: sortedAppointments.length,
      itemBuilder: (context, index) {
        final appointment = sortedAppointments[index];

        // Determine the color based on the appointment status
        Color statusColor;
        if (appointment.status == 'Completed') {
          statusColor = mainGreen;
        } else if (appointment.status == 'Pending') {
          statusColor = mainYellow;
        } else if (appointment.status == 'Running') {
          statusColor = Colors.blueGrey;
        }
        else {
          statusColor = Colors.red; // Use any color for other statuses
        }

        return Container(
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2), // Background color with slight opacity
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: statusColor, // Border color based on status
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              appointment.appointmentNumber.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: statusColor, // Text color matching the status
              ),
            ),
          ),
        );
      },
    );
  }
}
