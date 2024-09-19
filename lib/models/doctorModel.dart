class DoctorModel{

  final String id;
  final String dName;
  final String dtitle;
  final String dDescription;
  final String? doctorPic;

  // Constructor
  DoctorModel({
    required this.id,
    required this.dName,
    required this.dtitle,
    required this.dDescription,
    this.doctorPic,
  });

  // doctorData into json object
  Map<String, dynamic> toJSON(){
    return{
      'dName':dName,
      'dtitle':dtitle,
      'dDescription':dDescription,
      'doctorPic':doctorPic,
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