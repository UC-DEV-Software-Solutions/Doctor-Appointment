import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:firebase_testing/models/appointmentModel.dart';
import 'package:firebase_testing/services/appointment.dart';
import '../utils/constants.dart';

class PreviousAppointments extends StatefulWidget {
  final List<AppointmentModel> previousAppointments;
  final bool isAdmin; // New parameter to determine if the user is an admin

  const PreviousAppointments({
    Key? key,
    required this.previousAppointments,
    required this.isAdmin, // Pass whether the user is an admin or not
  }) : super(key: key);

  @override
  State<PreviousAppointments> createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  // Keeps track of the expanded state for each appointment
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    // Initialize the expanded state for all appointments as false
    _isExpanded = List.filled(widget.previousAppointments.length, false);
  }

  // Function to update appointment status in Firestore
  Future<void> _updateAppointmentStatus(String appointmentId, bool isCompleted) async {
    try {
      await AppointmentService().updateAppointmentStatus(appointmentId, isCompleted);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment marked as ${isCompleted ? 'Completed' : 'Pending'}')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating appointment status: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView inside a ScrollView or small container
      physics: const NeverScrollableScrollPhysics(), // Prevents independent scrolling
      itemCount: widget.previousAppointments.length,
      itemBuilder: (context, index) {
        final appointment = widget.previousAppointments[index];

        return Card(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appointment.status == 'Pending' ? mainYellow : mainGreen, // Background color based on status
                  borderRadius: BorderRadius.circular(12), // Makes the background rounded
                ),
                child: ListTile(
                  title: Text(appointment.patientName), // Display patient's name
                  subtitle: Text(
                    'Appointment Number: ${appointment.appointmentNumber}\n'
                        'Doctor: ${appointment.doctorName}\n'
                        'Date: ${getFormattedDate(appointment.selectedDate)}', // Display appointment details
                  ),
                  trailing: widget.isAdmin
                      ? Checkbox(
                    value: appointment.status == "Completed", // Mark as checked if status is Completed
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          // Update the appointment status based on the checkbox
                          _updateAppointmentStatus(appointment.aId, value);
                        });
                      }
                    },
                  )
                      : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      print('Attempting to delete appointment with ID: ${appointment.aId}');
                      AppointmentService().deleteAppointment(appointment.aId);
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _isExpanded[index] = !_isExpanded[index];
                    });
                  },
                ),
              ),
              // If expanded, show additional details
              if (_isExpanded[index])
                SizedBox(
                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${appointment.phoneNumber}'),
                      Text('Age: ${appointment.age}'),
                      Text('Reason: ${appointment.reason ?? "Not provided"}'),
                      Text('Booked On: ${getFormattedDate(appointment.createdAt)}'),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
