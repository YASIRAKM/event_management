import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPhoto with ChangeNotifier{
  List<XFile> selectedImages = [];
  List<String> imageUrls = [];
  final String selectedValue = '';
  File? imageFile;
  UploadTask? up;



  Future<void> pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );

    if (result != null && result.isNotEmpty) {
        selectedImages = result;
    }
    notifyListeners();
  }
  Future<void> uploadImages() async {
    for (var image in selectedImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName.jpg');
      UploadTask uploadTask = storageReference.putFile(File(image.path));

      await uploadTask.whenComplete(() async {
        String url = await storageReference.getDownloadURL();
          imageUrls.add(url);
      });
    }
    notifyListeners();
  }


  uploadImage1() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    imageFile = File(image!.path);
    var imPath = File(imageFile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$imPath");
    up = ref.putFile(imPath);
    final cmp = await up!.whenComplete(() {});
    var url = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    await db.setString('url', url);
    notifyListeners();
  }

  uploadImageC() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);
    var imPath = File(imageFile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$imPath");
    up = ref.putFile(imPath);
    final cmp = await up!.whenComplete(() {});
    var url = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    await db.setString('url', url);
    notifyListeners();
  }


}