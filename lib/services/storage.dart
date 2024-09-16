import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageServices{
  // create a storage instance
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // function for store the pictures to the storage and return the url
  Future<String> uploadImage(
      {
        required String folderName,
        required bool isPrescription,
        required Uint8List file,
      }
      )async{
      Reference ref = _storage.ref().child(folderName).child(_auth.currentUser!.uid);

      // if this is a prescription add another id
      if(isPrescription){
        String prescriptionId = const Uuid().v4();
        ref = ref.child(prescriptionId);
      }

      // upload the image to the storage
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL =await snapshot.ref.getDownloadURL();
      return downloadURL;

  }
}