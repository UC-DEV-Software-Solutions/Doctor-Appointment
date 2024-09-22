import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';

import '../models/appointmentModel.dart';
import '../services/appointment.dart';
import '../widgets/previousAppointments.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({super.key});

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text("All Appointments"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(stream: AppointmentService().getAppointments(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if(snapshot.hasError){
                return const Center(
                  child: Text("Error Loading Appointments"),
                );
              } else if(!snapshot.hasData || snapshot.data!.isEmpty){
                return const Center(
                  child: Text("No Previous Appointments"),
                );
              } else {
                final List<AppointmentModel> appointments = snapshot.data!;
                // Pass the list of AppointmentModel to PreviousAppointments
                return PreviousAppointments(previousAppointments: appointments,isAdmin: true,);
              }
            }),
      ),

    );
  }
}
