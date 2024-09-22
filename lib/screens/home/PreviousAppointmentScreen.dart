import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:firebase_testing/models/appointmentModel.dart';
// import 'package:firebase_testing/models/userModel.dart';
import 'package:firebase_testing/services/appointment.dart';
import 'package:firebase_testing/widgets/previousAppointments.dart';

import '../../models/UserModel.dart';
import '../../services/auth.dart';

class PreviousAppointmentScreen extends StatefulWidget {
  const PreviousAppointmentScreen({super.key});

  @override
  State<PreviousAppointmentScreen> createState() => _PreviousAppointmentScreenState();
}

class _PreviousAppointmentScreenState extends State<PreviousAppointmentScreen> {
  late Future<UserModel> _userData; // You need to initialize _userData appropriately

  @override
  void initState() {
    super.initState();
    // Initialize your _userData with an actual future that fetches the user data.
    _userData = AuthServices().getCurrentUser(); // Replace fetchUserData with your own function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text("Previous Appointments"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
          future: _userData,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError || !userSnapshot.hasData) {
              return const Center(child: Text("Error fetching user data"));
            }

            final user = userSnapshot.data!;
            return StreamBuilder<List<AppointmentModel>>(
              stream: AppointmentService().getAppointmentsWhere(
                field: 'uId',
                isEqualTo: user.uid,
              ),
              builder: (context, appointmentSnapshot) {
                if (appointmentSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (appointmentSnapshot.hasError) {
                  return const Center(child: Text("Error loading appointments"));
                } else if (!appointmentSnapshot.hasData || appointmentSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No previous appointments"));
                } else {
                  final List<AppointmentModel> appointments = appointmentSnapshot.data!;
                  return PreviousAppointments(
                    previousAppointments: appointments,
                    isAdmin: false,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

}
