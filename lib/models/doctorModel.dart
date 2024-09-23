import 'package:firebase_testing/models/appointmentModel.dart';

class DoctorModel{

  final String id;
  final String dName;
  final String dtitle;
  final String dDescription;
  final String? doctorPic;
  final List<AppointmentModel> appointments;

  // Constructor
  DoctorModel({
    required this.id,
    required this.dName,
    required this.dtitle,
    required this.dDescription,
    this.doctorPic,
    this.appointments = const [],
  });

  // doctorData into json object
  Map<String, dynamic> toJSON(){
    return{
      'dName':dName,
      'dtitle':dtitle,
      'dDescription':dDescription,
      'doctorPic':doctorPic,
      'id': id,

    };
  }

  // firebase Document object convert to dart doctorData
  factory DoctorModel.fromJSON(Map<String,dynamic> doc,String id){
    return DoctorModel(
        id: id,
        dName: doc['dName'],
        dtitle: doc['dtitle'],
        dDescription: doc['dDescription'],
        doctorPic: doc['doctorPic']
    );
  }

}