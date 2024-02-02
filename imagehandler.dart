
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'imagedialog.dart';

class ImagePickerHandler {
  late ImagePickerDialog imagePicker;
  late AnimationController _controller;
  late ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _crooper = ImageCropper();
  openCamera() async {
    imagePicker.dismissDialog();
    var image = await _picker.pickImage(source: ImageSource.camera);
    cropImage(image as File);
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    cropImage(image as File);
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    File croppedFile = (await _crooper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    )) as File;
    _listener.userImage(croppedFile);
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}