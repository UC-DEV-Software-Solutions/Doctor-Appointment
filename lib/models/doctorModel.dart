class DoctorModel{

  final String id;
  final String dName;
  final String dtitle;
  final String dDescription;
  final String doctorPic;

  // Constructor
  DoctorModel({
    required this.id,
    required this.dName,
    required this.dtitle,
    required this.dDescription,
    required this.doctorPic,
  });

  // doctorData into json object
  Map<String, dynamic> toJSON(){
    return{
      'id':id,
      'dName':dName,
      'dtitle':dtitle,
      'dDescription':dDescription,
      'doctorPic':doctorPic,
    };
  }

  // json object convert to doctorData
  factory DoctorModel.fromJSON(Map<String,dynamic> json){
    return DoctorModel(
        id: json['id'],
        dName: json['dName'],
        dtitle: json['dtitle'],
        dDescription: json['dDescription'],
        doctorPic: json['doctorPic']
    );
  }

}