import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/models/appointmentModel.dart';

class AppointmentService{

  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection("appointments");

  Future<void> addAppointment(String name,String phoneNumber,int age,String doctorName,String reason) async{
    try{

      final appointment = AppointmentModel(
          aId: "",
          patientName: name,
          phoneNumber: phoneNumber,
          age: age,
          doctorName: doctorName,
          reason: reason,
          createdAt: DateTime.now()
      );

      // Convert the Appointment to a map
      final Map<String,dynamic> data = appointment.toJSON();

      // Add the Appointment Data to the collection
      final docRef = await _appointmentCollection.add(data);

      // Update the appointment with the genarated id
      await docRef.update({"aId":docRef.id});
      print("Appointment Created. ID: ${docRef.id}");

      print("Appointment Successfully added");

    }catch(error){
      print('Error adding Appointment $error');
    }
  }

  // Method to get all Appointments from the Firestore
  Stream<List<AppointmentModel>> getAppointments(){
    return _appointmentCollection.snapshots().map((snapshot)=>snapshot.docs
    .map((doc)=> AppointmentModel.fromJSON(doc.data() as Map<String,dynamic>,
    doc.id)).toList());
  }

  Future<void> deleteAppointment(String aId) async{
    try{
      await _appointmentCollection.doc(aId).delete();
      print("Appointment Deleted Successfully");
    }catch(error){
      print("Deleting Error $error");
    }
  }

}