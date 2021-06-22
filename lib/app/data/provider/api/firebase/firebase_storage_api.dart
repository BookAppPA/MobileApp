import 'dart:io';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as i;

class FirebaseStorageAPI {
  Future<String> uploadPicture(
      String idUser, String path, String urlToDelete) async {
    return await _uploadFile(
        idUser, await _compressimage(File(path)), urlToDelete);
  }

  Future _compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    return compressedImagefile;
  }

  Future<String> _uploadFile(
      String idUser, File image, String urlToDelete) async {
    await deletePicture(idUser, [urlToDelete]);

    Reference storageReference;

    storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$idUser/pic_${image.hashCode}.jpg');

    UploadTask uploadTask = storageReference.putFile(image);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      print(uploadTask.snapshot);
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });
    try {
      await uploadTask;
      print('Upload complete.');
      return await storageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
        CustomSnackbar.snackbar("Vous n'avez pas la permission");
      }
      print(e);
      return null;
    }
  }

  deletePicture(String idUser, List<String> pictures) async {
    // Passage de parametre pour eviter toute dependances de controllers et models dans les fichiers API
    // Permet d'etre réutiliable et indépendant a 100%

    // Impossible de supprimer un dossier dans Storage donc liste tt les photos a supprimer
    // passe en param list picture de event au lieu de recup les URL directement dans Storage
    //    pour eviter de perdre du temps avec des nouveaux call API qui peuvent planter (exception)

    // Pas forEach car async / await bug parfois
    String start = "pic_";
    String end = ".jpg";
    for (int i = 0; i < pictures.length; i++) {
      if (pictures[i] == null || pictures[i] == "") return;
      int startIndex = pictures[i].indexOf(start);
      int endIndex = pictures[i].indexOf(end, startIndex + start.length);

      String url = pictures[i].substring(startIndex, endIndex + end.length);

      Reference storageReference =
          FirebaseStorage.instance.ref().child('users/$idUser/$url');
      try {
        await storageReference.delete();
      } catch (error) {
        print("API Firebase Storage: deletePicture: $error");
      }
    }
  }
}
