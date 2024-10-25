import 'dart:io';
import 'package:contractus/models/imageModel.dart'; // You might not need this anymore
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaController extends GetxController {
  final _picker = ImagePicker(); // Create a single ImagePicker instance

  String detail = '';

  // final RxList<String> imageUrls = RxList<String>([]);

  Future<ImageModel> getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? newImageUrl = await uploadImage(File(pickedFile.path));
      Get.snackbar(
        "Success!",
        "Your image has been uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return ImageModel(file: File(pickedFile.path), url: newImageUrl);
    } else {
      return ImageModel(file: null, url: null); // Handle no image selected
    }
  }

  Future<ImageModel> getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String? newImageUrl = await uploadImage(File(pickedFile.path));
      Get.snackbar(
        "Success!",
        "Your image has been uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return ImageModel(file: File(pickedFile.path), url: newImageUrl);
    } else {
      return ImageModel(file: null, url: null); // Handle no image selected
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'service_images/${DateTime.now().millisecondsSinceEpoch}.jpg'); // Generate unique filenames
      final uploadTask = storageRef.putFile(imageFile);

      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      if (error is FirebaseException) {
        print('Error uploading image: ${error.message} (code: ${error.code})');
      } else {
        print('Error uploading image: $error');
      }
      return null;
    }
  }
}
