import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as i;

class FirebaseStorageAPI {
  Future<String> uploadPicture(String idUser, String path) async {
    return await _uploadFile(idUser, await _compressimage(File(path)));
  }

  Future _compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    return compressedImagefile;
  }

  Future<String> _uploadFile(String idUser, File image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/$idUser/user_image.jpg');

    StorageUploadTask uploadTask = storageReference.putFile(image);

    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) {
      return await storageReference.getDownloadURL();
    }
    print("uploadfile: return null");
    //CustomSnackbar.snackbar(Localization.errorAPInoUploadPicture.tr);
    return null;
  }
}