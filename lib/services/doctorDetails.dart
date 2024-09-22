import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/models/doctorModel.dart';
import 'package:firebase_testing/services/storage.dart';

class DoctorDetailsService{

  final CollectionReference _doctorCollection =
  FirebaseFirestore.instance.collection("doctors");

  final StorageServices _storageServices = StorageServices();

  Future<void> addDoctor(String dName,String dtitle,String dDescription,Uint8List? doctorPic) async{
    try{

      String? photoURL;

      if(doctorPic != null){
        // upload the profilepic to the storage
        photoURL = await StorageServices().uploadImage(folderName: "DoctorImages", isPrescription: false, file: doctorPic);
      }

      final doctor = DoctorModel(
          id: "",
          dName: dName,
          dtitle: dtitle,
          dDescription: dDescription,
          doctorPic: photoURL,
      );

      // Convert the Doctor to a map
      final Map<String,dynamic> data = doctor.toJSON();

      // Add the Doctor Data to the collection
      final docRef = await _doctorCollection.add(data);

      // Update the appointment with the genarated id
      await docRef.update({"id":docRef.id});

      print("Doctor Successfully added");

    }catch(error){
      print('Error adding Doctor $error');
    }
  }

  // Method to get all Doctors from the Firestore
  Stream<List<DoctorModel>> getDoctors(){
    return _doctorCollection.snapshots().map((snapshot)=>snapshot.docs
        .map((doc)=> DoctorModel.fromJSON(doc.data() as Map<String,dynamic>,
        doc.id)).toList());
  }

  Future<void> deleteDoctors(String id) async{
    try{
      await _doctorCollection.doc(id).delete();
      print("Appointment Deleted Successfully");
    }catch(error){
      print("Deleting Error $error");
    }
  }

}