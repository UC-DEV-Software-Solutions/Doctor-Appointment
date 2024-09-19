import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/models/appointmentModel.dart';

class AppointmentService{

  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection("appointments");

  Future<void> addAppointment(String name,String phoneNumber,int age,String reason) async{
    try{

      final appointment = AppointmentModel(
          aId: "",
          patientName: name,
          phoneNumber: phoneNumber,
          age: age,
          reason: reason,
          createdAt: DateTime.now()
      );

      // Convert the Appointment to a map
      final Map<String,dynamic> data = appointment.toJSON();

      // Add the Appointment Data to the collection
      await _appointmentCollection.add(data);

      print("Appointment Successfully added");

    }catch(error){
      print('Error adding Appointment $error');
    }
  }

}