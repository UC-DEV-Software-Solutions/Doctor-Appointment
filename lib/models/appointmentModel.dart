class AppointmentModel{
  final String aId;
  final String patientName;
  final String phoneNumber;
  final int age;
  // final String doctorName;
  final String reason;

  // Constructor
  AppointmentModel({
    required this.aId,
    required this.patientName,
    required this.phoneNumber,
    required this.age,
    // required this.doctorName,
    required this.reason
});

  // AppointmentData into json object
  Map<String, dynamic> toJSON(){
    return{
      'patientName':patientName,
      'phoneNumber':phoneNumber,
      'age':age,
      'reason':reason,
    };
  }

  // firebase Document object convert to dart doctorData
  factory AppointmentModel.fromJSON(Map<String,dynamic> doc,String aId){
    return AppointmentModel(
        aId: 'aId',
        patientName: doc['patientName'],
        phoneNumber: doc['phoneNumber'],
        age: doc['age'],
        reason: doc['reason']
    );
  }

}