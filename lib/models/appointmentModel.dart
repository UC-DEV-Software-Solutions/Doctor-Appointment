import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel{
  final String aId;
  final String patientName;
  final String phoneNumber;
  final int age;
  // final String doctorName;
  final String reason;
  final DateTime createdAt;

  // Constructor
  AppointmentModel({
    required this.aId,
    required this.patientName,
    required this.phoneNumber,
    required this.age,
    // required this.doctorName,
    required this.reason,
    required this.createdAt
});

  // AppointmentData into json object
  Map<String, dynamic> toJSON(){
    return{
      'patientName':patientName,
      'phoneNumber':phoneNumber,
      'age':age,
      'reason':reason,
      'createdAt':createdAt
    };
  }

  // firebase Document object convert to dart doctorData
  factory AppointmentModel.fromJSON(Map<String,dynamic> doc,String aId){
    return AppointmentModel(
        aId: 'aId',
        patientName: doc['patientName'],
        phoneNumber: doc['phoneNumber'],
        age: doc['age'],
        reason: doc['reason'],
        createdAt: (doc['createdAt'] as Timestamp).toDate(),
    );
  }

}