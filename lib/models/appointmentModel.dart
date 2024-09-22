import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel{
  final String aId;
  final String patientName;
  final String phoneNumber;
  final int age;
  final String doctorName;
  final String? reason;
  final DateTime createdAt;
  final DateTime selectedDate;
  final int appointmentNumber;
  final String uId;
  final String status;

  // Constructor
  AppointmentModel({
    required this.aId,
    required this.patientName,
    required this.phoneNumber,
    required this.age,
    required this.doctorName,
    this.reason,
    required this.createdAt,
    required this.selectedDate,
    required this.appointmentNumber,
    required this.uId,
    required this.status,
});

  // AppointmentData into json object
  Map<String, dynamic> toJSON(){
    return{
      'patientName':patientName,
      'phoneNumber':phoneNumber,
      'age':age,
      'doctorName':doctorName,
      'reason':reason,
      'createdAt':createdAt,
      'selectedDate': selectedDate,
      'uId': uId,
      'appointmentNumber': appointmentNumber,
      'status': status
    };
  }

  // firebase Document object convert to dart doctorData
  factory AppointmentModel.fromJSON(Map<String,dynamic> doc,String aId){
    return AppointmentModel(
        aId: aId,
        patientName: doc['patientName'],
        phoneNumber: doc['phoneNumber'],
        age: doc['age'],
        doctorName: doc['doctorName'],
        reason: doc['reason'],
        createdAt: (doc['createdAt'] as Timestamp).toDate(),
        selectedDate: (doc['selectedDate'] as Timestamp).toDate(),
        uId: doc['uId'],
        status: doc['status'],
        appointmentNumber: doc['appointmentNumber']
    );
  }

}