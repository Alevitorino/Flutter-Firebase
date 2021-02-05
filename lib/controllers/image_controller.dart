import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final StreamController _blocController = StreamController.broadcast();
final getImagePicker = new ImagePicker();

class GetImageController {
  File iimage;

  Sink get input => _blocController.sink;
  Stream get output => _blocController.stream;

  getImageGallery() async {
     iimage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
   

    print("GET-IMAGE-CONTROLLER");
    input.add(iimage);
  }

  getImageCamera() async {
    iimage = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    input.add(iimage);
  }
}
