import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static Future<String> uploadImageNews(
      PlatformFile file,
      ) async {
    Uint8List imageFile = file.bytes!;
    String filename = file.name;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('camera_image')
        .child(filename.split('/').last);

    final UploadTask uploadTask = ref.putData(imageFile);

    final TaskSnapshot downloadUrl = await uploadTask;

    return await downloadUrl.ref.getDownloadURL();
  }
}
