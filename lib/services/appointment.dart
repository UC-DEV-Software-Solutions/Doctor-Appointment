import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/models/appointmentModel.dart';

class AppointmentService{

  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection("appointments");

  Future<void> addAppointment(String name,String phoneNumber,int age,String doctorName,String reason,DateTime selectedDate,String uId) async{
    try{

      // Step 1: Check the current number of appointments for the selected doctor and date
      final QuerySnapshot snapshot = await _appointmentCollection
          .where('doctorName', isEqualTo: doctorName)
          .where('selectedDate', isEqualTo: selectedDate)
          .get();

      int appointmentNumber = snapshot.size + 1; // Next appointment number for the doctor on the selected day


      final appointment = AppointmentModel(
          aId: "",
          patientName: name,
          phoneNumber: phoneNumber,
          age: age,
          doctorName: doctorName,
          reason: reason,
          createdAt: DateTime.now(),
          selectedDate: selectedDate,
          uId: uId,
          appointmentNumber: appointmentNumber,
          status: 'Pending',
      );

      // Convert the Appointment to a map
      final Map<String,dynamic> data = appointment.toJSON();

      // Add the Appointment Data to the collection
      final docRef = await _appointmentCollection.add(data);

      // Update the appointment with the genarated id
      await docRef.update({"aId":docRef.id});

      print("Appointment Created. ID: ${docRef.id}, Number: $appointmentNumber");

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

  // Method to get Appointments filtered by a specific field and value
  Stream<List<AppointmentModel>> getAppointmentsWhere({
    required String field,
    required String isEqualTo,
  }) {
    return _appointmentCollection
        .where(field, isEqualTo: isEqualTo)
        .snapshots()
        .map(
            (snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromJSON(
            doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // Method to get appointments by doctorName and today's date
  Stream<List<AppointmentModel>> getAppointmentsForSelectedDay({
    required String doctorName,
    required DateTime selectedDate,
  }) {
    // Get date with time stripped off
    DateTime startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    // Get the end of the day by adding one day and subtracting a microsecond
    DateTime endOfDay = startOfDay.add(Duration(days: 1));

    print("Doctor Name: $doctorName");
    print("Start of Day: $startOfDay");
    print("End of Day: $endOfDay");

    return _appointmentCollection
        .where('doctorName', isEqualTo: doctorName)
        .where('selectedDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('selectedDate', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => AppointmentModel.fromJSON(
        doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> deleteAppointment(String aId) async{
    try{
      await _appointmentCollection.doc(aId).delete();
      print("Appointment Deleted Successfully");
    }catch(error){
      print("Deleting Error $error");
    }
  }

  // // Method to get the current running appointment for a doctor on a specific day
  // Future<AppointmentModel?> getCurrentRunningAppointment(
  //     String doctorName, DateTime selectedDate) async {
  //   final QuerySnapshot snapshot = await _appointmentCollection
  //       .where('doctorName', isEqualTo: doctorName)
  //       .where('selectedDate', isEqualTo: selectedDate)
  //       .where('status', isEqualTo: 'in-progress') // Get the running appointment
  //       .limit(1)
  //       .get();
  //
  //   if (snapshot.docs.isNotEmpty) {
  //     var appointmentData = snapshot.docs.first.data() as Map<String, dynamic>;
  //     return AppointmentModel.fromJSON(appointmentData, snapshot.docs.first.id);
  //   } else {
  //     return null; // No running appointment found
  //   }
  // }

  // Add this method in AppointmentService
  Future<void> updateAppointmentStatus(String appointmentId, bool isCompleted) async {
    try {
      await _appointmentCollection.doc(appointmentId).update({
        'status': isCompleted ? "Completed" : "Pending",
      });
      print("Appointment status updated to ${isCompleted ? 'Completed' : 'Pending'}");
    } catch (error) {
      print("Error updating appointment status: $error");
    }
  }

}